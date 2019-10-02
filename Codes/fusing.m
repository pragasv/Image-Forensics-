close all;
clear all;
clc;

A = imread('Original/ucid/ucid00001.tif');
B= imread('Original/ucid/ucid00144.tif');
B= imresize(B,0.2)

C = imfuse(A,B)

imshow(C)
