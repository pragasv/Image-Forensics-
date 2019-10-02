load trainData2.csv
load meas.csv
load trainLabelsDataComplete.csv




grp2idx(trainLabelsDataComplete);

x = meas(1:42,:);
y = trainLabelsDataComplete(1:42,:);

rand_num = randperm(42);

X_train = x(rand_num(1:34),:);
y_train = y(rand_num(1:34),:);

X_test = x(rand_num(35:end),:);
y_test = y(rand_num(35:end),:);

c = cvpartition(y_train,'k',5);

opts = statset('display','iter');
fun = @(train_data,train_labels,test_data,test_labels)...
sum(predict(fitcsvm(train_data,train_labels,'KernelFunction','RBF'),test_data) ~= test_labels);


%[fs,history] =sequentialfs(fun,X_train,y_train,'cv',c,'options',opts)
X_train_W_best_features = X_train(:,:);

%Mdl = fitcsvm(X_train_W_best_features,y_train);
Mdl = fitcsvm(X_train_W_best_features,y_train,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto');
%Mdl = fitcsvm(X_train_W_best_features,y_train,'OptimizeHyperparameters','auto',...
   % 'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
   % 'expected-improvement-plus'))    ;

CVSVMModel = crossval(Mdl);
classLoss = kfoldLoss(CVSVMModel);

sv = Mdl.SupportVectors;

figure
gscatter(X_train_W_best_features(:,1),X_train_W_best_features(:,2),y_train)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('1','0','Support Vector')
hold off

X_test_w_best_feature =X_test(:,:);
accuracy = sum(predict(Mdl,X_test_w_best_feature)== y_test)/length(y_test)*100;