close all;
clear all;
clc;

img = imread('E:\seniors projects\nipuni akki project - IT\Test\resampling\resampling\New folder\1.tiff');
img = rgb2gray(img);
img = double(img);

[f1,f2,f3,f4] = extractFeaturesFunc(img,256);

label = classifyImages([f1,f2,f3,f4]);

if (label==1)
    disp('This is a resampled image');
    %resampled location finder 
    resamplelocator(img);
    
else
    disp('This image is not resampled');
end
