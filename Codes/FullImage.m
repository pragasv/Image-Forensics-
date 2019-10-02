I = imread('kodim01.png');

YourImage = im2double(I);
[m,n, ~] = size(YourImage);
nob=(m/64)*(n/64);
Blocks = cell(m/64,n/64);
counti = 0;
for i = 1:64:m-63
   counti = counti + 1;
   countj = 0;
   for j = 1:64:n-63
        countj = countj + 1;
        Blocks{counti,countj} = YourImage(i:i+63,j:j+63);
        
        %[Pmap, varargout] = emresampleN(img,N,varargin)
   end
   
end

for i = 1:nob
    
     [f1,f3,f4,f5] = testImage

end


figure;imshow(Block(:,:,1))