function PredictY = LR(Labeled, TestX)

nLabel = size(Labeled.X, 1);
nTest = size(TestX, 1);

Beta = regress(Labeled.Y, [Labeled.X ones(nLabel,1)]);
PredictY = [TestX ones(nTest,1)] * Beta;

end