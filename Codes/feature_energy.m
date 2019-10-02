close all;
clear all;
clc;


% ==========================================
% IMAGE PARAMETERS 
impath = 'F:\Project\Test\resampling\resampling';
imprefix = 'kodim';
imIdx = 8;
cropCorner = [100 100];

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
[H,W,~] = size(im);

for k = 1:length(resampleRatio)   
    r = resampleRatio(k);   
    cropWidth = floor(M/r);
    
    
    
    img = double(im(cropCorner(1):cropCorner(1)+cropWidth-1, ...
                    cropCorner(2):cropCorner(2)+cropWidth-1));
                    
    %abve code only snips jst one part of box in the main image ,
    %100:157,100:157, should alter this to crop multiple segments using
    %imcrop.
    
    
    
    %disp(size(img));
    
    img = imresize(img,[M M],'bilinear');    
    
    [pmap,cen,RN,RS,Y] = emresample(img,N,'verbose');
    %fprintf('Pmap');
    %disp(pmap);              %probability
     
     p1 =  fft2c(pmap); 
     periodicitymap = fft2(pmap); 
    % fprintf('fmap');
   %  disp(periodicitymap);  
     %y = highpass(periodicitymap,0.00001)
   realPeriodicityMap = abs(periodicitymap);
   Ndecimals = 2 ;
    f = 10.^Ndecimals ; 
   realPeriodicityMap= round(f*realPeriodicityMap)/f ;

  fprintf(' realPeriodicityMap');
  disp(realPeriodicityMap);
  
  periodicitymapRow = reshape(realPeriodicityMap, 1, []); 
  %disp(periodicitymapRow);
  
    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow((rmcenter(p1)),[]);
    
    filename = sprintf('F:\Project\Test\resampling\resampling\figures\im%i_r%.2f.png',imIdx,(r-1)*100);
    print('-deps',filename);
    
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracting first feature


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

       R= 0;
       energy = periodicitymap.*conj(periodicitymap);
       disp('Total energy :');
       disp(energy);
       for plength = 1: length(energy)
            
           R = R + energy(plength);
           
       end
        energymapRow = reshape(energy, 1, []);
        [sortedVal, sortedInds] = sort(energymapRow,'descend');
         topVal = sortedVal(1:1);
         fprintf('max value :');
         disp(topVal);
        
         R = ( topVal / R);
       
       f5 = ((10000*R)^m) /100;
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
