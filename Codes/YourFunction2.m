
   
 function [result,pmap,fmap] = YourFunction2(block_of_image)
    
  % result = double(max(block_of_image(:))) ./ sum(double(block_of_image(:)));  
    N=2;
    pmap = emresampleN(block_of_image,N,'verbose');                  
    fmap = fft2c(pmap);
    result = fft2c(pmap);
    pmap = pmap;
    %fprintf('pmap');
    %disp(pmap);
    fmap = fftshift(fft2(fftshift(pmap)));
    
   
    
    figure;
    subplot(131)
    imshow(block_of_image,[])
    subplot(132)
    imshow(pmap,[])
    subplot(133)
    imshow(abs(rmcenter(fmap)),[]);
    

 
   