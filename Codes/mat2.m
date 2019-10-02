clear all; 
clc;
close all;

im = imread('kodim01.png');

block_of_image = 'kodim01.png';
[H,W,~] = size(im);
N = 4;

[result] = yourFunction(im);
aux_fun = @(block_info) yourFunction(block_info.block);
result = blockproc(im, [64 64], aux_fun);

fprintf('hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');