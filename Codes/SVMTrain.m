close all;
    clear all;
    load ImageDataSet.csv
    load ImageDataSetLabels.csv
    load PhotoshopPredict.csv
   %grp_idx = grp2idx(FeatureLabels);
    X = ImageDataSet(1:1763,:);
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
     SVMModel = fitcsvm(X_train,y_train,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto','OutlierFraction',0.05);
    CVSVMModel = crossval(SVMModel);
    classLoss = kfoldLoss(CVSVMModel)
    classOrder = SVMModel.ClassNames
    sv = SVMModel.SupportVectors;
   figure
   gscatter(X_train(:,1),X_train(:,2),y_train)
   hold on
   plot(X_train(SVMModel.IsSupportVector,1),X_train(SVMModel.IsSupportVector,2),'ko','MarkerSize',10)
   legend('Resampled','Non','Support Vector')
   hold off
   X_test_w_best_feature =X_test(:,:);
   [c,score] = predict(SVMModel,X_new_data);
   
   axis([0 200 0 5000]);
   saveCompactModel(SVMModel,'SVM1000Images');