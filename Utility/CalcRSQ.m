function Rsq = CalcRSQ(TestY, PredictY)

nParameter = size(TestY,2);
Rsq = zeros(1,nParameter);

for i=1:nParameter
    R = corrcoef(TestY(:,i), PredictY(:,i));
    Rsq(i) = R(1,2)^2;
end