I = imread('Original/ucid/ucid00001.tif') ;
[J,rect] = imcrop(I) ;
[nx,ny,~] = size(I) ;
[nx1,ny1,~] = size(J) ;
%% place at random location 
posx = randsample(nx1:nx-nx1,1) ;
posy = randsample(ny1:ny-ny1,1) ;
%place the cropped part 
I(posx:posx+nx1-1,posy:posy+ny1-1,:) = J ;
imshow(I) 