clc;

img=imread('Original/ucid/ucid00001.tif');
image_gray= rgb2gray(img);
[n m ~]= size(image_gray);
L = 50;

% Crop
crop = image_gray(randi(n-L+1)+(0:L-1),randi(m-L+1)+(0:L-1));

A = imread('Original/ucid/ucid00001.tif');



C = imfuse(A,crop)





imshow(C)
