function calPerformance(PredictY, TestY)
RSQ = CalcRSQ(PredictY, TestY);
MAE = CalcMAE(PredictY, TestY);

disp(['RSQ: ' num2str(RSQ)]);
disp(['MAE: ' num2str(MAE)]);
end