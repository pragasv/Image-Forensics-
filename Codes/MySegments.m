close all;
clear all;
clc;

nSegHorz = 0;
nSegVert = 0;


img = imread('Original\ucid\ImageDataSet\ucid00320sp.tif');
imgr = rgb2gray(img);

[H W c] = size(imgr)


x = mod(H,57)
y = mod(H,57)
    

nSegVert = floor((H-x)/57) ;
nSegHorz = floor((W-y)/57) ;

totalSegments = nSegVert * nSegHorz

cropCorner = [1 1];
cropwidth = 1

N = 2;


for i = 1 : nSegVert
    for k = 1 : nSegHorz
        
        x1 = k*57 - 56
        x2 = k*57
        y1 = i*57 - 56
        y2 = i*57
        
        img = double(imgr(y1:y2,x1:x2));
        
        pmap = emresampleN(img,N,'verbose');
        % p1 =  fft2c(pmap); 
        periodicitymap = fft2c(pmap); 
        
        figure;
        subplot(131)
        imshow(img,[])
        subplot(132)
        imshow(pmap,[])
        subplot(133)
        imshow(abs(rmcenter(periodicitymap)),[]);
    
        
    end
    
        figure;
        subplot(131)
        imshow(img,[])
        subplot(132)
        imshow(pmap,[])
        subplot(133)
        imshow(abs(rmcenter(periodicitymap)),[]);
    
end

      
    
    
    
   
    
    






