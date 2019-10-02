close all;
clear all;
clc;
%img = imread('Original\ucid\ucid00005sp.tif');

img = imread('Original\ucid\ImageDataSet\Predicting\ucid00758sp.tif');
%img = imread('Original\ucid\ucid00440.tif');
%img = imread('CASIA\Au\Au_ani_30546.jpg');
%img = imread('out.jpg');

img = rgb2gray(img);
img = double(img);


%Pmap = emresampleN(img,N,varargin)

[result,pmap,fmap] = YourFunction3(img);
[f1,f3,f4,f5] = extractFeaturesFunctionNew(img);
label = classifyImages();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (label==1)
    disp('This is a resampled image');
    %resampled location finder 
    %locateResampling(img);
    figure1 = figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    %imshow(abs(rmcenter(fmap)),[]);
    %subplot(134)
    imagesc(pmap)
	saveas(figure1,'out_image.jpg')
    
else
    disp('This image is not resampled');
end


