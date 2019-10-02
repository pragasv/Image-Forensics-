close all
clear all

% ==========================================
% IMAGE PARAMETERS 
impath = 'F:\Project\Test\resampling\resampling';
imprefix = 'kodim';
imIdx = 8;
cropCorner = [100 100];

% RESAMPLING PARAMETERS
resampleRatio = 1 + ([0 2.5 5 10] ./ 100);
resampleRatio = 1.1;

N = 2;   % window size
M = 400 ; % block size
% ==========================================

if(imIdx < 10)
    impath = sprintf('%s/%s0%i.png',impath,imprefix,imIdx);   
% elseif(imIdx < 100)
%     impath = sprintf('../data/0%i.jpg', imIdx);    
% else
%     impath = sprintf('../data/%i.jpg', imIdx);    
end

im  = imread('kodim06.png');
[H,W,~] = size(im);

for k = 1:length(resampleRatio)   
    r = resampleRatio(k);   
    cropWidth = floor(M/r);
        
   img = double(im(cropCorner(1):cropCorner(1)+cropWidth-1, ...
                    cropCorner(2):cropCorner(2)+cropWidth-1));
    img = imresize(img,[M M],'bilinear');    
    pmap = emresample(img,N,'verbose');                  
    fmap = fft2c(pmap); 
   
    fprintf('###########');
    %disp(pmap);
    pmapRow = reshape(pmap, 1, []); 
    fmapRow = reshape(fmap, 1, []); 
    %sortedMap = sort(pmapRow,'descend');
    %disp(sortedMap);
    
    %%
    
    N = 10;
    sum = 0 ;
    %%
    [ b, ix ] = sort(  pmapRow(:), 'descend' );
    %%
    [ rr, cc ] = ind2sub( size( pmapRow), ix(1:N) );
    %%
    for ii = 1 : N
       disp(  pmapRow( rr(ii), cc(ii) ) )
       sum = sum + (pmapRow( rr(ii), cc(ii)));
      
    end
     disp(sum);
     %disp(fmap);
      N2 = 10;
      sum2 = 0 ;
    %%
    [ b, ix ] = sort(  abs(fmapRow(:)), 'descend' );
    %%
    [ rr, cc ] = ind2sub( size( fmapRow), ix(1:N) );
    %%
    for ii = 1 : N2
       disp(  fmapRow( rr(ii), cc(ii) ) )
       sum2 = sum2 + (fmapRow( rr(ii), cc(ii)));
      
    end
     disp(sum2);
     
    
      
     

   
    % display p-map
    figure;
    subplot(131)
    imshow(img,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
    
    filename = sprintf('F:\Project\Test\resampling\resampling\figures\im%i_r%.2f.png',imIdx,(r-1)*100);
    print('-deps',filename);
    
   
    
    rowVector = reshape(pmap, 1, []);  
    %pcaVal= pca(rowVector);
    %disp(rowVector);
    
    covariance = cov(pmap);
    %disp(covariance);
    [eigenvec, eigenval ] = eig(covariance);
     
    d = eigs(covariance,10);
    %disp(d);
    eigsVector = reshape(d, 1, []);  
    %disp(eigsVector);
    
    %dlmwrite('m04.csv', d,'delimiter',',');
    %xlswrite('m07 .xls',eigsVector);
    %csvwrite('m10.csv',eigsVector)
    dlmwrite('m11.csv',eigsVector,'-append')
    %largest_eigenval = eigenval(3,3);
    %disp(largest_eigenval);
    
   ;
 end  

