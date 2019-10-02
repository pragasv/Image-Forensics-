load ionosphere
rng(1); % For reproducibility
n = size(X,1);       % Training sample size
isInds = 1:(n-10);   % In-sample indices
oosInds = (n-9):n;   % Out-of-sample indices

SVMModel = fitcsvm(X(isInds,:),Y(isInds),'Standardize',true,...
    'ClassNames',{'b','g'});
CompactSVMModel = compact(SVMModel);
whos('SVMModel','CompactSVMModel')

CompactSVMModel = fitPosterior(CompactSVMModel,...
    X(isInds,:),Y(isInds))

[labels,PostProbs] = predict(CompactSVMModel,X(oosInds,:));
table(Y(oosInds),labels,PostProbs(:,2),'VariableNames',...
    {'TrueLabels','PredictedLabels','PosClassPosterior'})