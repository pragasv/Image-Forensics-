
%% Training and testing the the SVM ( 100: 157 part is used to train,test and predict)
close all;
clear all;


load ImageDataSet2.csv
load ImageDataSetLabels.csv
load PhotoshopPredict.csv

%grp_idx = grp2idx(FeatureLabels);

X = ImageDataSet2(1:1763,:);
y = ImageDataSetLabels(1:1763,:);
X_new_data = PhotoshopPredict(1:end,:);

%dividing the dataset into training and testing 
rand_num = randperm(1763);

%training Set
X_train = X(rand_num(1:1410),:);
y_train = y(rand_num(1:1410),:);

%testing Set
X_test = X(rand_num(1411:end),:);
y_test = y(rand_num(1411:end),:);

%preparing validation set out of training set
 
c = cvpartition(y_train,'k',5);

%%feature selection
opts = statset('display','iter');
%fun = @(train_data,train_labels,test_data,test_labels)...
   % sum(predict(fitcsvm(train_data,train_labels,'KernelFunction','rbf'),test_data)~=test_labels)
%[fs,history] = sequentialfs(fun,X_train,y_train,'cv',c,'options',opts,'nfeatures',2)

SVMModel = fitcsvm(X_train,y_train,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto','OutlierFraction',0.05);

CVSVMModel = crossval(SVMModel);
[cl,scorePred] = kfoldPredict(CVSVMModel);
outlierRate = mean(scorePred<0)
figure
gscatter(X(:,1),X(:,2),y);
h = gca;
lims = [10 20]; % Extract the x and y axis limits
title('{\bf Scatter Diagram of Iris Measurements}');
xlabel('Petal Length (cm)');
ylabel('Petal Width (cm)');
legend('Location','Northwest');

classLoss = kfoldLoss(CVSVMModel)

classOrder = SVMModel.ClassNames




%genError = kfoldLoss(SVMModel)
X_test_w_best_feature =X_test(:,:);
%predict(SVMModel,X_test_w_best_feature)
%bp = (predict(SVMModel,X_test)== y_test);
fprintf("Scores : ");
[c,score] = predict(SVMModel,X_new_data);
%bp = sum((predict(SVMModel,X_test)== y_test)/length(y_test))*100;
disp(score);


saveCompactModel(SVMModel,'SVM1000Images');

