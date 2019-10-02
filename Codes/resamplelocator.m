function [im1] = resamplelocator(img)
%this will give the exact location of the resampling 
    
    [H,W]=size(img);
    
    
    
    for i=1:64:H-64;
        for j=1:64:W-64;
            
            fprintf('i and j values printed');
            disp([i,j]);
            
            [f1,f2,f3,f4]=extractFeaturesFunc(imcrop(img,[i j i+64 j+64]),64)
            label = classifyImages([f1,f2,f3,f4]);
            if (label ==1)
                figure;
                imshow(uint8(img));
              
                hold on; 
                rectangle('Position',[i j i+64 j+64]);
        end
    end
    

end

