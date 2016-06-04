function PredictY = PCR(Labeled,Unlabeled,TestX,nDim)

nLabel = size(Labeled.X, 1);

% Training
if isempty(Unlabeled)
    Train.X = Labeled.X;
else
    Train.X = [Labeled.X; Unlabeled.X];
end

[Transformed, Mapping] = compute_mapping(Train.X, 'PCA', nDim);
TrainTransformed.Y = Labeled.Y;
TrainTransformed.X = Transformed(1:nLabel,:);
TestTransformedX = out_of_sample(TestX, Mapping);
PredictY = LR(TrainTransformed, TestTransformedX);


end