function [model] = libMCCR_train(Labeled, Unlabeled, Group, Method, nDim, update_times)
% Labeled: Labeled.X is a n*d matrix,and Labeled.Y is the corresponding reference vector
% Group: include two m*d matrices (Group.X and Group.Y)
% Method: GCCA, MCCR or GMCCR
% nDim: optimal dimensions
% update_times: the update times in pre-training process

switch lower(Method)
    case 'gcca'
        model = gcca_train(Labeled, Group, nDim);
    case 'mccr'
        model = mccr_train(Labeled, Unlabeled, nDim, update_times);
    case 'gmccr'
        model = gmccr_train(Labeled, Group, nDim, update_times);
    otherwise
        disp('Unknown method');
        model = [];
        return;
end

end

function [model] = gcca_train(Labeled, Group, nDim)
% sorting the labeled data
[~,idxL]=sort(Labeled.Y);
nLabel = size(Labeled.X, 1);
n = floor(size(Labeled.X,1)/2);
m = min(size(Group.X,1),size(Group.Y,1));

% construct two views
Group1 = Group.X(1:m,:);
Group2 = Group.Y(1:m,:);
View.X = [Labeled.X(idxL(1:n),:);Group1];
View.Y = [Labeled.X(idxL(n+1:2*n),:);Group2];

% CCA Transform
[Wx, Wy, ~] = CCA(View.X', View.Y');
TrainTransformed.X = Labeled.X * real([Wx Wy]);

% PCR
[PCATrans, PCAMapping] = compute_mapping(TrainTransformed.X, 'PCA', nDim);
X = PCATrans; Y = Labeled.Y;
Beta = regress(Y, [X ones(nLabel,1)]);

model.Beta = Beta;
model.Wx = Wx;
model.Wy = Wy;
model.PCAMapping = PCAMapping;
end

function [model] = mccr_train(Labeled, UnLabeled, nDim, update_times)
%% Maximum contributed component regression (model)
% sorting labeled data
[~,idxL]=sort(Labeled.Y);
n= floor(size(Labeled.X,1)/2);
m= floor(size(UnLabeled.X,1)/2);

nLabel = size(Labeled.X, 1);

% initial the pre-training set (labeled and unlabeled)
TempLabel.X = Labeled.X;
TempLabel.Y = Labeled.Y;
TempUnlabel = UnLabeled.X;

% co-training
for i=1:update_times
    hatY = PCR(TempLabel, [], TempUnlabel, nDim);
    [~,idxU]=sort(hatY);
    View.X = [Labeled.X(idxL(1:n),:);UnLabeled.X(idxU(1:m),:)];
    View.Y = [Labeled.X(idxL(n+1:2*n),:);UnLabeled.X(idxU(m+1:2*m),:)];
    % CCA Transform
    [Wx, Wy, ~] = CCA(View.X', View.Y');
    TempLabel.X = Labeled.X * real([Wx Wy]);
    TempUnlabel = UnLabeled.X * real([Wx Wy]);
end

% PCR
TrainTransformed.Y = Labeled.Y;
TrainTransformed.X = Labeled.X * real([Wx Wy]);
[PCATrans, PCAMapping] = compute_mapping(TrainTransformed.X, 'PCA', nDim);
X = PCATrans; Y = Labeled.Y;
Beta = regress(Y, [X ones(nLabel,1)]);

model.Beta = Beta;
model.Wx = Wx;
model.Wy = Wy;
model.PCAMapping = PCAMapping;
end

function [model] = gmccr_train(Labeled, Group, nDim,update_times)
% sorting the labeled data
[~,idxL]=sort(Labeled.Y);
nLabel = size(Labeled.X, 1);
n = floor(size(Labeled.X,1)/2);
m = min(size(Group.X,1),size(Group.Y,1));

Group1 = Group.X(1:m,:);
Group2 = Group.Y(1:m,:);

% initial the pre-training set (labeled and unlabeled)
tempTrain.X=Labeled.X;
tempTrain.Y=Labeled.Y;
tempGroup = [Group1;Group2];

for i=1:update_times
    hatY = PCR(tempTrain,[],tempGroup ,nDim);
    [~,idxG1]=sort(hatY(1:m));[~,idxG2]=sort(hatY(m+1:2*m));
    View.X = [Labeled.X(idxL(1:n),:);Group1(idxG1,:)];
    View.Y = [Labeled.X(idxL(n+1:2*n),:);Group2(idxG2,:)];
    % CCA Transform
    [Wx, Wy, ~] = CCA(View.X', View.Y');
    tempTrain.X = Labeled.X * real([Wx Wy]);
    tempGroup = [Group1;Group2] * real([Wx Wy]);
end
% PCR
TrainTransformed.X = Labeled.X * real([Wx Wy]);
[PCATrans, PCAMapping] = compute_mapping(TrainTransformed.X, 'PCA', nDim);
X = PCATrans; Y = Labeled.Y;
Beta = regress(Y, [X ones(nLabel,1)]);

model.Beta = Beta;
model.Wx = Wx;
model.Wy = Wy;
model.PCAMapping = PCAMapping;
end