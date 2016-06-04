function [PredictY] = libMCCR_test(TestX, model)

nTest = size(TestX, 1);
% CCA Transform
TestTransformedX = TestX * real([model.Wx model.Wy]);
X = out_of_sample(TestTransformedX, model.PCAMapping);
PredictY = [X ones(nTest,1)] * model.Beta;

end