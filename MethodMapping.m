function [PredictY]=MethodMapping(Labeled,Unlabeled,TestX,Method,nDim,update_times)
Regress = 'PCR';
NoisyRatio = 0; % messy ratio of two groups
switch lower(Method)
    case 'pls'
        PredictY = PLS(Labeled,TestX,nDim);
    case 'pca'
        %PredictY = PCR(Labeled, Unlabeled, TestX,nDim);
        PredictY = PCR(Labeled, [], TestX,nDim);
    case 'kernelpca'
        PredictY = KernelPCR(Labeled,[],TestX,nDim,Regress);
    case 'fa'
        PredictY = FARegress(Labeled,[],TestX,nDim,Regress);
    case 'lpp'
        PredictY = LPPRegress(Labeled,Unlabeled,TestX,nDim,Regress);
    case 'gcca'
        PredictY = GCCARegress(Labeled, Unlabeled, TestX, nDim, false , Regress, NoisyRatio);
    case 'bgcca'
        PredictY = GCCARegress(Labeled, Unlabeled, TestX, nDim, true , Regress);
    case 'bgcca+pls'
        PredictY = GCCARegress(Labeled, Unlabeled, TestX, nDim, true , 'PLS');
    case 'mccr'
        preRegress = 'PCR';
        PredictY =MCCR(Labeled, Unlabeled, TestX, nDim, Regress,preRegress,update_times);
    case 'gmccr'
        preRegress = 'PCR';
        PredictY =GMCCR(Labeled, Unlabeled, TestX, nDim, Regress,preRegress,update_times,NoisyRatio);
    case 'mccr+pls'
        preRegress = 'PLS';
        PredictY = MCCR(Labeled, Unlabeled, TestX, nDim, Regress,preRegress,update_times);
    case 'mccr+real'
        preRegress = 'PCR';
        PredictY = realMCCR(Labeled, Unlabeled, TestX, nDim, Regress,preRegress,update_times);
    otherwise
        disp('Unknown method');
        PredictY=[];
end

end