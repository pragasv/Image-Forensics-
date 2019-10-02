Foreground_image = imread('Original/ucid/ucid00001.tif');

Foreground_image = uint8(Foreground_image); %RGB values 0Black-255White

figure; fId = imagesc(Foreground_image); axis image; %Let me look at the foreground image

title('Drag mouse to select pixels for image'); %Tell me to draw defined space

A = imfreehand(); %Lets me freehand draw to select the certain pixels I want

maskImg = A.createMask;
image2(A) = Foreground_image(A);