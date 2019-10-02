myfun = @(block_struct) imresize(block_struct.data,0.15);
I = imread('kodim01.png');
I2 = blockproc(I,[25 25],myfun);