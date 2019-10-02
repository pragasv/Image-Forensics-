%% Check the image to be classified


clc;    
close all;
workspace; 
format longg;
format compact;
fontSize = 20;

folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'Photoshop_Resampled\ucid00274sp.tif';



rgbImage = imread(baseFileName);
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
col1 = 1;
col2 = floor(columns/2);
col3 = col2 + 1;
row1 = 1;
row2 = floor(rows/2);
row3 = row2 + 1;

% Now crop
upperLeft = imcrop(imgr, [col1 row1 col2 row2]);
subplot(2, 3, 2);
imshow(upperLeft);


%%%Lower Left



imIdx = 8;
%cropCorner = [100 100];
cropCorner = [col1 row1]

% RESAMPLING PARAMETERS

resampleRatio = 1;

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
     
   img = double(upperLeft(row1:row2, ...
                    col1:col2 ));  
                
     %img = imcrop(imgr, [col1 row1 col2 row2]);
                  
  % img = imresize(img,[M M],'bilinear');    
    pmap = emresampleN(img,N,'verbose');                  
    fmap = fft2c(pmap);
    
   
end     
     
lowerLeft = imcrop(imgr, [col1 row3 col2 row2]);
subplot(2, 3, 2);
imshow(lowerLeft);

imIdx = 8;
%cropCorner = [100 100];
cropCorner = [col1 row3]

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
     
   img = double(lowerLeft);           
     
                  
   % img = imresize(img,[M M],'bilinear');    
    pmap = emresampleN(img,N,'verbose');                  
    fmap = fft2c(pmap);
    
    %disp(fmap);
    
     % display p-map
    subplot(2, 3, 2);
    imshow(upperLeft);
    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
    
    % display p-map
    subplot(2, 3, 5);
    imshow(lowerLeft);

    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
       
end  
%%%%Upper Right

upperRight = imcrop(imgr, [col3 row1 columns - col2 row2]);
subplot(2, 3, 2);
imshow(upperRight);

imIdx = 8;
%cropCorner = [100 100];
cropCorner = [col1 row3]

% RESAMPLING PARAMETERS

resampleRatio = 1.1;

N = 2;   % window size
M = 16 % block size
 
im  = baseFileName;
[H,W,~] = size(imgr);

for k = 1:length(resampleRatio)   
    r = resampleRatio(k);   
  
   img = double(upperRight);           
     
    pmap = emresampleN(img,N,'verbose');                  
    fmap = fft2c(pmap);
  
    % display p-map
    subplot(2, 3, 3);
    imshow(upperRight);

    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
       
    
end 

%%Lower Right

lowerRight = imcrop(imgr, [col3 row3 columns - col2 rows - row2]);
subplot(2, 3, 2);
imshow(upperRight);

imIdx = 8;
%cropCorner = [100 100];
cropCorner = [col1 row3]

% RESAMPLING PARAMETERS

resampleRatio = 1.1;

N = 2;   % window size
M = 16 % block size
 
im  = baseFileName;
[H,W,~] = size(imgr);

for k = 1:length(resampleRatio)   
    r = resampleRatio(k);   
  
   img = double(lowerRight);           
     
    pmap = emresampleN(img,N,'verbose');                  
    fmap = fft2c(pmap);
    
   
    % display p-map
    subplot(2, 3, 3);
    imshow(lowerRight);

    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
     
end    









