I = imread('kodim01.png') ;
I = rgb2gray(I) ;
[nx,ny] = size(I) ;
%% to split into kx*ky blocks 
kx = 64 ; ky = 64 ;
%% Chnage dimensions of image so that exactly divisible 
nx0 = nx+(kx-mod(nx,kx)) ;
ny0 = ny+(ky-mod(ny,ky)) ;
%%
I1 = uint8(zeros(nx0,ny0)) ;
I1(1:nx,1:ny) = I ;
%% Divide into blocks 
kx0 = nx0/kx ; % rows in block
ky0 = ny0/ky ; % columns in block 
Y = mat2cell(I1, repmat(kx0,[1 size(I1,1)/kx0]), repmat(ky0,[1 size(I1,2)/ky0]));
disp(Y);