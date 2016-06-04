function [Train, TestX, TestY, Labeled, Unlabeled, Group] = SplitData(Data, nTrain, nTest, nLabel, nUnlabel)

nData = size(Data.Y, 1);
Index = randperm(nData);

% Split into Train and Test
Train.X = Data.X(Index(1:nTrain),:); Train.Y = Data.Y(Index(1:nTrain));
TestX = Data.X(Index(nTrain+1:nTrain+nTest),:); TestY = Data.Y(Index(nTrain+1:nTrain+nTest));

% Split into Labeled and Unlabeled
Labeled.X = Train.X(1:nLabel,:);
Labeled.Y = Train.Y(1:nLabel);
Unlabeled.X = Train.X(nLabel+1:nLabel+nUnlabel,:);
Unlabeled.Y = Train.Y(nLabel+1:nLabel+nUnlabel);

% Split into Group
nUnlabel = floor(size(Unlabeled.X, 1)/2);
Group.X = Unlabeled.X(1:nUnlabel,:);
Group.Y = Unlabeled.X(nUnlabel+1:2*nUnlabel,:);

end
