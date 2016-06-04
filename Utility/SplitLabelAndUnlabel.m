function [Labeled, Unlabeled] = SplitLabelAndUnlabel(Train, nLabel)
Labeled.X = Train.X(1:nLabel,:);
Labeled.Y = Train.Y(1:nLabel);
Unlabeled.X = Train.X(nLabel+1:end,:);
Unlabeled.Y = Train.Y(nLabel+1:end);
end