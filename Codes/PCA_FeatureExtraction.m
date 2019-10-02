close all
clear all

% ==========================================
% IMAGE PARAMETERS 
impath = 'F:\Project\Test\resampling\resampling';
imprefix = 'kodim';
imIdx = 8;
cropCorner = [100 100];

% RESAMPLING PARAMETERS
resampleRatio = 1 + ([0 2.5 5 10] ./ 100);
resampleRatio = 1.8;

N = 2;   % window size
M = 64; % block size
% ==========================================

if(imIdx < 10)
    impath = sprintf('%s/%s0%i.png',impath,imprefix,imIdx);   
% elseif(imIdx < 100)
%     impath = sprintf('../data/0%i.jpg', imIdx);    
% else
%     impath = sprintf('../data/%i.jpg', imIdx);    
end

im  = imread('kodim24.png');
[H,W,~] = size(im);

for k = 1:length(resampleRatio)   
    r = resampleRatio(k);   
    cropWidth = floor(M/r);
        
   img = double(im(cropCorner(1):cropCorner(1)+cropWidth-1, ...
                    cropCorner(2):cropCorner(2)+cropWidth-1));
    img = imresize(img,[M M],'bilinear');    
    pmap = emresample(img,N,'verbose');                  
    fmap = fft2c(pmap); 
   
    fprintf('###########');
    %disp(pmap);
    %pmapRow = reshape(pmap, 1, []); 
    fmapRow = reshape(fmap, 1, []); 
    %sortedMap = sort(pmapRow,'descend');
    %disp(sortedMap);
    
    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
    
    filename = sprintf('F:\Project\Test\resampling\resampling\figures\im%i_r%.2f.png',imIdx,(r-1)*100);
    print('-deps',filename);
    
   
    
    rowVector = reshape(fmap, 1, []);  
    covariancee = cov(fmap);
    
    eigVal = eigs(covariancee,10);
    disp(eigVal);
    
    
     
    eigsVector = reshape(eigVal, 1, []);  
    disp(eigsVector);
    
    %dlmwrite('m04.csv', d,'delimiter',',');
    %xlswrite('m07 .xls',eigsVector);
    %csvwrite('m10.csv',eigsVector)
    dlmwrite('m12.csv',eigsVector,'-append')
    %largest_eigenval = eigenval(3,3);
    %disp(largest_eigenval);
    
   % features = eigsVector;
    %SVMstruct = svmtrain(features, class, 'Kernel_Function', 'rbf');
    %newclass = svmclassify(SVMstruct, [40 5]);
   
    %trainData = csvread('trainData2.csv');
    %trainLabels = csvread('trainLabelsData2.csv');
    %testData = csvread('test.csv');
    
    %options = optimset('maxiter',100000);
    %SVMstruct = svmtrain(trainData,trainLabels);
    %SVMstruct = svmtrain(trainData,trainLabels,'showplot',true,'Kernel_Function','rbf','Polyorder',2,'quadprog_opts',options);
    %SVMstruct = svmtrain(trainData,trainLabels,'showplot',true,'Kernel_Function','rbf','rbf_sigma',0.5);
   
    %p = 0.5;
    %[Train,Test] = crossvalind('HoldOut',trainLabels,p);
    
    
    %Group = svmclassify( SVMstruct,testData);
    
   
 end  

