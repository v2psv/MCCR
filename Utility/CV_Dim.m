function [opt_dim] = CV_Dim(Labeled, Unlabeled, Group, Method, update_times, cv)

% check and set default arguments
if nargin<6
    cv = 10;
end
if nargin<5
    update_times = 4;
end
if nargin<4
    Method = 'MCCR';
end

% check the size of arrays
if size(Labeled.X,1) ~= length(Labeled.Y)
    disp('Labeled.Y must be a vector and must have the same number of rows as Labeled.X.');
    return;
end
if size(Labeled.X,2) ~= size(Unlabeled.X,2)
    disp('Labeled.X must have the same number of columns as UnLabeled.X.');
    return;
end

nLabel = size(Labeled.X,1);
sub =ceil(nLabel/cv)+1;
MaxDim = nLabel - sub;
RSQ = zeros(MaxDim,1);
cvo = cvpartition(nLabel,'kfold',cv);
PredictY = zeros(nLabel,MaxDim);
TestY = zeros(nLabel,1);
for iDim = 1:MaxDim
    for j = 1:cvo.NumTestSets
        itrain = cvo.training(j);
        itest = cvo.test(j);
        dataLabeled.X = Labeled.X(itrain,:); dataLabeled.Y = Labeled.Y(itrain);
        TestX = Labeled.X(itest,:);  TestY(itest)= Labeled.Y(itest);
%         [PredictY(itest,iDim)]=MethodMapping(dataLabeled,Unlabeled,TestX,Method,iDim,update_times);
        model = libMCCR_train(dataLabeled, Unlabeled, Group, Method, iDim, update_times);
        [PredictY(itest,iDim)] = libMCCR_test(TestX, model);
    end
    RSQ(iDim) = CalcRSQ(PredictY(:,iDim), TestY);
end

[~,opt_dim] = max(RSQ);

end