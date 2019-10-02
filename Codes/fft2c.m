function y = fft2c(x)
y = fftshift(fft2(fftshift(x)));

%disp(y);