%load FeatureCopy.csv
load FeatureLabelsNum.csv
%load FeatureData.csv
load FeatureOne.csv
load NewData.csv

%grp_idx = grp2idx(FeatureLabels);

X = FeatureOne(1:42,:);
y = FeatureLabelsNum(1:42,:);
X_new_data = NewData(1:end,:);

%dividing the dataset into training and testing 
rand_num = randperm(42);

%training Set
X_train = X(rand_num(1:34),:);
y_train = y(rand_num(1:34),:);

%testing Set
X_test = X(rand_num(34:end),:);
y_test = y(rand_num(34:end),:);

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

classLoss = kfoldLoss(CVSVMModel)

classOrder = SVMModel.ClassNames

%Mdl = fitcsvm(X_train,y_train,'OptimizeHyperparameters','auto',...
   % 'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
    %'expected-improvement-plus'))
sv = SVMModel.SupportVectors;
figure
gscatter(X_train(:,1),X_train(:,2),y_train)

hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)

legend('Resampled','Non','Support Vector')
hold off

%genError = kfoldLoss(SVMModel)
X_test_w_best_feature =X_test(:,:);
%predict(SVMModel,X_test_w_best_feature)
%bp = (predict(SVMModel,X_test)== y_test);
[~,score] = predict(SVMModel,X_new_data);
%bp = sum((predict(SVMModel,X_test)== y_test)/length(y_test))*100;


file = 'F:\Project\Test\resampling\resampling'
save  file SVMModel

