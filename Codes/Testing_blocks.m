close all;
clear all;
clc;


% ==========================================
% IMAGE PARAMETERS 
impath = 'F:\Project\Test\resampling\resampling';
imprefix = 'kodim';
imIdx = 8;
%cropCorner = [100 100];
%cropCorner = [10 10];


% RESAMPLING PARAMETERS
%resampleRatio = 1 + ([0 2.5 5 10] ./ 100);
resampleRatio = 1.1;

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

im  = imread('kodim12.png');
%im =  imcrop(im,[512, 512, 512,512]);
[H,W,~] = size(im);

for winh = 1:H-100
    for winw = 1:W-100
        cropCorner = [winh winw];
    end
end

fprintf('Blocks');
numBlocks = ((H*W)/(M*M));
disp(numBlocks);
for k = 1:length(resampleRatio)  
 %for k = 1:numBlocks
    r = resampleRatio;   
   cropWidth = floor(M/r);
   % cropWidth = 21;
    
    img = double(im(cropCorner(1):cropCorner(1)+cropWidth-1, ...
                    cropCorner(2):cropCorner(2)+cropWidth-1));
       
    %abve code only snips jst one part of box in the main image ,
    %100:157,100:157, should alter this to crop multiple segments using
    %imcrop.
    
    
    
    %disp(size(img));
    
    img = imresize(img,[M M],'bilinear');    
    
    [pmap,cen,RN,RS,Y] = emresample(img,N,'verbose');            %probability map                
    periodicitymap = fft2c(pmap);                  %periodicity map
   
    %disp(periodicitymap);
    fprintf('Value of r :');
    disp(RN);
  
    % display p-map
    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(periodicitymap)),[]);
    
    filename = sprintf('F:\Project\Test\resampling\resampling\figures\im%i_r%.2f.png',imIdx,(r-1)*100);
    print('-deps',filename);
    
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  %Extracting Feature1
  
  realPeriodicityMap = abs(periodicitymap);
  fprintf('####################################');
  %disp(realPeriodicityMap);
  
  periodicitymapRow = reshape(realPeriodicityMap, 1, []); 
  %disp(periodicitymapRow);
  n = 4;
  m=2;
  sum = 0; 
 
  [sortedVal, sortedInds] = sort(periodicitymapRow,'descend');
  top4 = sortedVal(1:4)

  
    for ii = 1 : N
      
       sum = sum + top4(ii);
      
    end
      fprintf('Sum : ');
      disp(sum);
      
      f1 = (m*sqrt(sum));
      fprintf('Feature 01 : ');
      disp(f1);
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Extracting second feature
 


%maxCoeff =  max(periodicitymapRow(:));
[ max_value, max_index ] = max( periodicitymapRow );
%maxCoeff =  max(periodicitymapRow);
%disp(max_value );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting Feature 3

for h = 1 : H
    for w = 1:W
 % value = pdist2([cen H],[cen W],'euclidean');
   f3 = sqrt((cen-H)^2 + (cen-W)^2); 
 
    end
end

   fprintf('Feature 03 : ');
   disp(f3);
%value = sqrt((cen-m)^2 + (cen-n)^2); 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting Feature 4
  sumf4 = 0;
  f4 = ((100*RS).^m)/100;
  fprintf('Feature 04 : ');
  disp(f4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting Feature 5

       sumf5 = 0 ;
       f5 = ((10000*RN)^m) /100;
       fprintf('Feature 05 : ');
       disp(f5);
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%create feature array

feature_array = [f1,f3,f4,f5];
fprintf('Original Values : ');

for  le = 1:length(feature_array)
      disp(feature_array(le));
      
end
fprintf('##############################');
fprintf('\n');


minVal = min(feature_array);
%disp(minVal);
feature_array=feature_array - minVal;

maxVal = max(feature_array);
feature_array = feature_array / maxVal;

disp( feature_array);




 
 
end