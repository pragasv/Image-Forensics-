I = imread('kodim01.png');
[r c ~]=size(I);
bs=64; % Block Size (8x8)

nob=(r/bs)*(c/bs); % Total number of 8x8 Blocks

% Dividing the image into 8x8 Blocks
kk=0;
for i=1:(r/bs)
for j=1:(c/bs)
Block(:,:,kk+j)=I((bs*(i-1)+1:bs*(i-1)+bs),(bs*(j-1)+1:bs*(j-1)+bs));
end
%kk=kk+(r/bs);
kk=kk+1;
end

% Accessing individual Blocks

figure;imshow(Block(:,:,1)) % This shows u the fist 8x8 Block in a figure window
figure;imshow(Block(:,:,2)) % This shows u the second 8x8 Block (i.e as per my %coding rows from 1:8 and col from 9:16) in a figure window and so on..... 

% Looking at Histograms of Individual Blocks

figure;imhist(Block(:,:,1)) % Displays histogram window of first Block
figure;imhist(Block(:,:,2)) % Displays histogram window of second Block andso on.....
