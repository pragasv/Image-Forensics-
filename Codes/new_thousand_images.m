clear all;
close all; 
clc ; 


%%%load the supplimentary image 
im2=imresize(rgb2gray(imread('ucid00886.tif')),[64 64]);

myFolder = 'F:\Project\Test\resampling\resampling\kodim\';
filePattern = fullfile(myFolder, '*.png'); % Change to whatever pattern you need.
theFiles = dir(filePattern);



for k = 1 : length(theFiles)-1
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  
  fprintf(1, 'Now reading %s\n', fullFileName);
  % Now do whatever you want with this file name,
  % such as reading it in as an image array with imread()
  imageArray = imread(fullFileName);

  

    angle=90.*rand(1,1);
    %size=2.*rand(1,1)-0.5;
    im2=imrotate(im2,angle,'crop');
    
    x=floor(size(imageArray,1).*rand(1,1)+1);
    y=floor(size(imageArray,2).*rand(1,1)+1);
   %x = 100:157
   %y= 100:157
    
    %imageArray(x:x+size(im2,1)-1,y:y+size(im2,2)-1)=im2(1:size(im2,1),1:size(im2,2)); 
    imageArray(100:163,100:163)=im2(1:size(im2,1),1:size(im2,2)); 
    
    
    myFolder_1 = 'F:\Project\Test\resampling\resampling\Original\editedkodim';
    if ~exist(myFolder_1,'dir')
        mkdir(myFolder_1);
    end
    
    fullFileName_1 = fullfile(myFolder_1, sprintf('%d.png',k));
    
    imwrite(imageArray,fullFileName_1);
  
  
end


