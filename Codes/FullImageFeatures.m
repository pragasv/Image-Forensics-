%% Check the Upper-Right part of the image to be classified

clc;    % Clear the command window. 
close all;
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;
fontSize = 20;
% Read in a standard MATLAB color demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
%baseFileName = 'Photoshop_Resampled\ucid00068sp.tif';
baseFileName = 'Original\ucid\ImageDataSet\ucid00008sp.tif';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
	% Didn't find it there.  Check the search path for it.
	fullFileName = baseFileName; % No path this time.
	if ~exist(fullFileName, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
rgbImage = imread(fullFileName);
% Get the dimensions of the image.  numberOfColorBands should be = 3.
[rows columns numberOfColorBands] = size(rgbImage);
% Display the original color image.
subplot(2, 3, 1);
imshow(rgbImage, []);
imgr = rgb2gray(rgbImage);
%imshow(imgr, []);

title('Original Color Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Get the rows and columns to split at,
% Taking care to handle odd-size dimensions:




imIdx = 8;
%cropCorner = [100 100];


% RESAMPLING PARAMETERS

resampleRatio = 1.1;

N = 2;   % window size
M = 16 % block size
 
im  = baseFileName;
[H,W,~] = size(imgr);

for k = 1:length(resampleRatio)   
    r = resampleRatio(k);   
    %cropWidth = floor(M/r);
   %  cropWidth = 256;   
   %  cropWidthCol = 192; 
  % img = double(upperLeft(cropCorner(1):cropCorner(1)+cropWidth-1, ...
                   % cropCorner(2):cropCorner(2)+cropWidthCol-1));
     
   img = double(imgr);           
     
                  
   % img = imresize(img,[M M],'bilinear');    
    pmap = emresampleN(img,N,'verbose');                  
    p1 =  fft2c(pmap); 
     periodicitymap = fft2c(pmap); 
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
    
    % display p-map
    subplot(2, 3, 3);
    imshow(imgr);

    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
     
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extracting first feature


  n = 4;
  m=2;
  sum1 = 0; 
 
  [sortedVal, sortedInds] = sort(periodicitymapRow,'descend');
  top4 = (abs( sortedVal(1:4)));

  
    for ii = 1 : n
        sum1 = sum1 + top4(ii);
    end
    
      fprintf('sum1 : ');
      disp(sum1);
      
      f1 = (m*sqrt(sum1));
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
%fimg = fft2(im);
fimgss = periodicitymap(2:end,2:end);    %skip the zero-order components
absfimg = abs(fimgss);
meanabs = mean(absfimg(:));
[sortdiff, diffidx] = sort(abs( absfimg(:) - meanabs ), 'descend');
ssfar4 = diffidx(1:4);
f13frabs = sortdiff(1)+sortdiff(2)+sortdiff(3)+sortdiff(4); 
f3 = f13frabs ;                               %sum1 of the abs of the frequency differences
f13frorig = sum(fimgss(ssfar4));  %sum of the complex frequency differences
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting Feature 4

localEnergyMap = periodicitymap.*conj(periodicitymap);

aux_fun = @(block_info) YourFunction(block_info.data);
result = blockproc(localEnergyMap, [64 64], aux_fun, 'TrimBorder', false)

f4 = (((100*result).^m)/100);
fprintf('feature 04');
disp(f4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting Feature 5

R= 0;
energy = periodicitymap.*conj(periodicitymap);
%disp('Total energy :');
%disp(energy);
       
%for plength = 1: length(energy)
  %  R = R + energy(plength);
%end
    R = sum(sum(energy));
fprintf('R value :');
disp(R);

energymapRow = reshape(energy, 1, []);
[sortedVal, sortedInds] = sort(energymapRow,'descend');
topVal = sortedVal(1:1);
        
fprintf('max value :');
disp(topVal);
        
R = ( topVal / R);
       
f5 = ((10000*R).^m) /100;
fprintf('Feature 05 : ');
disp(f5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%feature06
f6 = (f3-f4);
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%create feature array

feature_arrayO = [f1,f3,f4,f5,f6];
fprintf('Original Values : ');

feature_array = [f1,f3,f4,f5,f6];
for  le = 1:length(feature_array) 
    disp(feature_array(le));
      
end
fprintf('##############################');
fprintf('\n');


minVal = min(feature_array);
%disp(minVal);
feature_array=feature_array - minVal;

maxVal = max(feature_array);
feature_arrayN = (feature_array / maxVal);

disp( feature_arrayN);

%feature_arrayN[1]*100000;
dlmwrite('PhotoshopPredict2.csv',feature_arrayO,'-append');
%csvwrite('m2.csv',feature_arrayN);
    
    
    
    
end    








