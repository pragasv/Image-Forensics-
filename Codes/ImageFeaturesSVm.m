
%% Training and testing the the SVM ( 100: 157 part is used to train,test and predict)
close all;
clear all;
clc;


load ImageFeatures.csv
load ImageFeaturesLabels.csv
load ImageFeaturesPredict2.csv

%grp_idx = grp2idx(FeatureLabels);

X = ImageFeatures(1:101,:);
y = ImageFeaturesLabels(1:101,:);
X_new_data = ImageFeaturesPredict2(1:end,:);

%dividing the dataset into training and testing 
rand_num = randperm(101);

%training Set
X_train = X(rand_num(1:81),:);
y_train = y(rand_num(1:81),:);

%testing Set
X_test = X(rand_num(82:end),:);
y_test = y(rand_num(82:end),:);

%preparing validation set out of training set
 
c = cvpartition(y_train,'k',5);

%%feature selection
opts = statset('display','iter');
%fun = @(train_data,train_labels,test_data,test_labels)...
   % sum(predict(fitcsvm(train_data,train_labels,'KernelFunction','rbf'),test_data)~=test_labels)
%[fs,history] = sequentialfs(fun,X_train,y_train,'cv',c,'options',opts,'nfeatures',2)



SVMModel = fitcsvm(X_train,y_train,'Standardize',false,'KernelFunction','RBF',...
    'KernelScale','auto','OutlierFraction',0.05);

CVSVMModel = crossval(SVMModel);

classLoss = kfoldLoss(CVSVMModel)

classOrder = SVMModel.ClassNames

%Mdl = fitcsvm(X_train,y_train,'OptimizeHyperparameters','auto',...
   % 'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    %'expected-improvement-plus'))
sv = SVMModel.SupportVectors;

figure
gscatter(X_train(:,1),X_train(:,2),y_train)

hold on
plot(X_train(SVMModel.IsSupportVector,1),X_train(SVMModel.IsSupportVector,2),'ko','MarkerSize',10)
%plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)

legend('Resampled','Non','Support Vector')
hold off



%genError = kfoldLoss(SVMModel)
X_test_w_best_feature =X_test(:,:);
%predict(SVMModel,X_test_w_best_feature)
%bp = (predict(SVMModel,X_test)== y_test);
fprintf("Scores : ");
[c,score] = predict(SVMModel,X_test);
%bp = sum((predict(SVMModel,X_test)== y_test)/length(y_test))*100;
disp(score);

%axis([0 100000 0 5000]);
%axis([0 1000 0 5000]);
%axis tight;
set(gca,'yscale','log');
set(gca,'xscale','log');
%axis([0 100000 0 5000]);
%saveCompactModel(SVMModel,'SVM1000Images');
saveCompactModel(SVMModel,'SVMImageData');
%saveCompactModel(C.ClassificationSVM, 'mySVM')
%CompactSVMModel = compact(SVMModel);
%CompactSVMModel = compact(SVMModel);

