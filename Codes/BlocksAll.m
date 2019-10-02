clc;    % Clear the command window. 
close all;
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;
fontSize = 20;
% Read in a standard MATLAB color demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'Original\ucid\ImageDataSet\ucid00871p.tif';
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

imIdx = 8;
%cropCorner = [100 100];
cropCorner = [col1 row1]

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
     
   img = double(upperLeft(row1:row2, ...
                    col1:col2 ));           
     %img = imcrop(imgr, [col1 row1 col2 row2]);
                  
   % img = imresize(img,[M M],'bilinear');    
    pmap = emresampleN(img,N,'verbose');                  
    fmap = fft2c(pmap);
    
    %disp(fmap);
    
    
    
    % display p-map
    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
     
   % filename = sprintf('F:/Project/ImgPro/EM/im%i_r%.2f.png',imIdx,(r-1)*100);
   
  %  imwrite(fmap,filename)
    
   
    %print('-deps',filename);
    
    
    
    
    
end    




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Upper Right

upperRight = imcrop(rgbImage, [col3 row1 columns - col2 row2]);
colN= columns - col2;
subplot(2, 3, 2);
imshow(upperRight);

imIdx = 8;
%cropCorner = [100 100];
cropCorner = [col3 row1]

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
    
   img = double(upperRight(row1:row2, ...
                    col3:colN));           
     %img = imcrop(imgr, [col1 row1 col2 row2]);
                  
   % img = imresize(img,[M M],'bilinear');    
    pmap = emresampleN(img,N,'verbose');                  
    fmap = fft2c(pmap);
    
    %disp(fmap);
    
    
    
    % display p-map
    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
       
end    

%lowerLeft = imcrop(rgbImage, [col1 row3 col2 row2]);
%lowerRight = imcrop(rgbImage, [col3 row3 columns - col2 rows - row2]);
% Display the images.
subplot(2, 3, 2);
imshow(upperLeft);
%subplot(2, 3, 3);
%imshow(upperRight);
%subplot(2, 3, 5);
%imshow(lowerLeft);
%subplot(2, 3, 6);
%imshow(lowerRight);

