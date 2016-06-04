function [Train, Test] = SplitTrainAndTest(Data, nTrain, nTest)

nData = size(Data.Y, 1);
Index = randperm(nData);

% Split into Train and Test
Train.X = Data.X(Index(1:nTrain),:); Train.Y = Data.Y(Index(1:nTrain));
Test.X = Data.X(Index(nTrain+1:nTrain+nTest),:); Test.Y = Data.Y(Index(nTrain+1:nTrain+nTest));

end
