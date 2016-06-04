function MAE = CalcMAE(TestY, PredictY)

[nTest, nParameter] = size(TestY);
ParameterMean = mean(TestY,1);
MAE = zeros(nTest,nParameter);

% Percentage MAE
for i = 1:nTest
    for j = 1:nParameter
        MAE(i,j) = abs(TestY(i,j)-PredictY(i,j));
    end
end

MAE = mean(MAE,1);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           