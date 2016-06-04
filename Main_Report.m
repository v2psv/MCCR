clear;close all;
% matlabpool local 9;

addpath Utility;

tic;
DatasetsName = {'SiHT', 'SiTCD', 'SiBCD','MaskHT','SiO2HT', 'ROX'};

nDataset = length(DatasetsName);

for i=1:nDataset
    load(['Data/' DatasetsName{i} '.mat']);
    % Noisy=(rand(size(MatX(:,11:end)))-0.5)*NoisyLevel;
    DataSets{i}.MatX = MatX(:,11:end);
    DataSets{i}.MatY = MatY;
end

nLabelFull = [13];

nUnlabelFull= 500;
nTest = 1000;
Methods = {'GCCA','MCCR','GMCCR'};

nMethod = length(Methods);
nIter = 1;
update_times = 4;
cv = 10;

for iData=1:nDataset
    nData = size(DataSets{iData}.MatX, 1);
    nFeature = size(DataSets{iData}.MatX, 2);
    Data.X = DataSets{iData}.MatX; Data.Y = DataSets{iData}.MatY;
    for iLabel=1:length(nLabelFull)
        nLabel = nLabelFull(iLabel);
        nUnlabel = nUnlabelFull;
        nTrain = nLabel + nUnlabel;
        fprintf('iData=%d, iLabel=%d.\n',iData,iLabel);
        for iIter = 1:nIter
            PredictY = [];
            % Split into Training and Testing Set
            [Train, Test] = SplitTrainAndTest(Data, nTrain, nTest);
            % Normalized data by zero mean and unit variance
            %Test.X = Normalize(Train.X, Test.X);
            %Train.X = Normalize(Train.X, Train.X);
            
            % Split into Labeled and Unlabeled
            [Labeled, Unlabeled] = SplitLabelAndUnlabel(Train, nLabel);
            
            nUnlabel = floor(size(Unlabeled.X, 1)/2);
            Group.X = Unlabeled.X(1:nUnlabel,:);
            Group.Y = Unlabeled.X(nUnlabel+1:2*nUnlabel,:);
            %[Labeled, Unlabeled] = GroupSplitLabelAndUnlabel(Train, nLabel, nUnlabel);
            for iMethod=1:nMethod
                opt_dim = CV_Dim(Labeled,Unlabeled, Group, Methods{iMethod},update_times,cv);
                [model] = libMCCR_train(Labeled, Unlabeled, Group, Methods{iMethod}, opt_dim, update_times);
                [PredictY(:,iMethod)] = libMCCR_test(Test.X, model);
                %                 [PredictY(:,iMethod)]=MethodMapping(Labeled,Unlabeled,Test.X,Methods{iMethod},opt_dim,update_times);
                RSQ(iIter,iMethod) = CalcRSQ(PredictY(:,iMethod), Test.Y);
                MAE(iIter,iMethod) = CalcMAE(PredictY(:,iMethod), Test.Y);
            end
        end
        RSQMean{iData}(iLabel,:) = mean(RSQ,1); RSQStd{iData}(iLabel,:) = std(RSQ,1);
        MAEMean{iData}(iLabel,:) = mean(MAE,1); MAEStd{iData}(iLabel,:) = std(MAE,1);
    end
end

save report_10fold RSQMean MAEMean RSQStd MAEStd
% matlabpool close;
toc;