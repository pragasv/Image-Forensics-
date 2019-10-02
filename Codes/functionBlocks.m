clc;    
    close all;
    workspace; 
    format longg;
    format compact;
    fontSize = 20;
    folder = fullfile(matlabroot, '\toolbox\images\imdemos');
    baseFileName = 'Original\ucid\ImageDataSet\ucid00320sp.tif';
    rgbImage = imread(baseFileName);
     % Get the dimensions of the image.  numberOfColorBands should be = 3.
    [rows columns numberOfColorBands] = size(rgbImage);
    % Display the original  color image.
    subplot(2, 3, 1);
    imshow(rgbImage, []);
    imgr = rgb2gray(rgbImage);
    title('Original Color Image', 'FontSize', fontSize);
    % Enlarge figure to full screen.
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    % Get the rows and columns to split at,
    % Taking care to handle odd-size dimensions:
    col1 = 1;
    col2 = floor(columns/2);
    col3 = col2 + 1;
    row1 = 1;
    row2 = floor(rows/2);
    row3 = row2 + 1;
     lowerLeft = imcrop(imgr, [col1 row3 col2 row2]);
     subplot(2, 3, 2);
     imshow(lowerLeft);
    upperLeft = imcrop(imgr, [col1 row1 col2 row2]);
    subplot(2, 3, 2);
    imshow(upperLeft);
    upperRight = imcrop(imgr, [col3 row1 columns - col2 row2]);
    subplot(2, 3, 2);
    imshow(upperRight);
    lowerRight = imcrop(imgr, [col3 row3 columns - col2 rows - row2]);
    subplot(2, 3, 2);
    
    imshow(upperRight);
    
     blockArray = {upperLeft, lowerLeft,upperRight, lowerLeft};
   for i=1:length(blockArray)
    imIdx = 8;
    % RESAMPLING PARAMETERS
    resampleRatio = 1.1;
    N = 2;   % window size
    M = 16 % block size
   im  = baseFileName;
   [H,W,~] = size(imgr);
    for k = 1:length(resampleRatio)   
      r = resampleRatio(k);   
   img = double(blockArray{i});       
   % img = imresize(img,[M M],'bilinear');    
    pmap = emresampleN(img,N,'verbose');                  
    periodicitymap = fft2c(pmap);
    
    subplot(2, 3, 3);
    imshow(imgr);
     
   realPeriodicityMap = abs(periodicitymap);
   Ndecimals = 2 ;
   f = 10.^Ndecimals ; 
   realPeriodicityMap= round(f*realPeriodicityMap)/f ;

  fprintf(' realPeriodicityMap');
  disp(realPeriodicityMap);
  
  periodicitymapRow = reshape(realPeriodicityMap, 1, []); 
  %disp(periodicitymapRow);
  
    %disp(fmap);
    % display p-map
    subplot(2, 3, 3);
    imshow(blockArray{i});
    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(periodicitymap)),[]);
    end    
     
    
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
result = blockproc(img, [H W], aux_fun, 'TrimBorder', false)

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

%dlmwrite('PhotoshopPredictFull.csv',feature_arrayO,'-append');
   end