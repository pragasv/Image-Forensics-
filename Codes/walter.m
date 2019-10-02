I = imread('kodim01.png'); 
m= fft2(I);%for example
aux_fun = @(block_info) YourFunction(block_info.data);
result = blockproc(m, [64 64], aux_fun, 'TrimBorder', false)
disp(result);


