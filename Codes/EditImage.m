clear all;
close all; 
clc ; 


%%%load the supplimentary image 
im2=imresize(rgb2gray(imread('ucid00886.tif')),[64 64]);

myFolder = 'F:\Project\Test\resampling\resampling\Original\ucid\';
filePattern = fullfile(myFolder, '*.tif'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)-1
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  
  fprintf(1, 'Now reading %s\n', fullFileName);
  % Now do whatever you want with this file name,
  % such as reading it in as an image array with imread()
  imageArray = imread(fullFileName);

  

    angle=90.*rand(1,1);
    
    im2=imrotate(im2,angle);
    
    x=floor(size(imageArray,1).*rand(1,1));
    y=floor(size(imageArray,2).*rand(1,1));
    
    imageArray(x:x+size(im2,1)-1,y:y+size(im2,2)-1)=im2(1:size(im2,1),1:size(im2,2)); 
    
    
    myFolder_1 = 'F:\Project\Test\resampling\resampling\Original\ucid\edited';
    
    if ~exist(myFolder_1,'dir')
        mkdir(myFolder_1);
    end
    
    
    imwrite(imageArray,fullfile(myFolder_1, sprintf('%d.tif',k)));
  
  
end


