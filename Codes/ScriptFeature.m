 
close all
clear all

imIdx = 8;
cropCorner = [100 100];

% RESAMPLING PARAMETERS

resampleRatio = 3.0;

N = 2;   % window size
M = 512 % block size
 
im  = imread('Original/bec.jpg');
[H,W,~] = size(im);

for k = 1:length(resampleRatio)   
    r = resampleRatio(k);   
    cropWidth = floor(M/r);
        
    img = double(im(cropCorner(1):cropCorner(1)+cropWidth-1, ...
                    cropCorner(2):cropCorner(2)+cropWidth-1));
    img = imresize(img,[M M],'bilinear');    
    pmap = emresampleN(img,N,'verbose');                  
    fmap = fft2c(pmap);
    
    disp(fmap);
    
    
    
    % display p-map
    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
    
    filename = sprintf('F:/Project/ImgPro/EM/im%i_r%.2f.png',imIdx,(r-1)*100);
   
    imwrite(fmap,filename)
    
   
    %print('-deps',filename);
    
    
    
    
    
    
    
    
    
    
    
end    

