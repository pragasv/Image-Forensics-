clc;    
    close all;
    workspace; 
    format longg;
    format compact;
    fontSize = 20;
    folder = fullfile(matlabroot, '\toolbox\images\imdemos');
    baseFileName = 'Original\ucid\ImageDataSet\ucid00485sp.tif'
    rgbImage = imread(baseFileName);
     % Get the dimensions of the image.  numberOfColorBands should be = 3.
    [rows columns numberOfColorBands] = size(rgbImage);
    % Display the original color image.
    subplot(2, 3, 1);
    imshow(rgbImage, []);
    imgr = rgb2gray(rgbImage);
    title('Original Color Image', 'FontSize', fontSize);
    % Enlarge figure to full screen.
    set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    % Get the rows and columns to split at,
    % Taking care to handle odd-size dimensions:
    [H W ~] = size(imgr)
     
   
    
    col1 = 1;
    col2 = floor(columns/4);
    col1_1 = col2 - 1;
    col3 = floor(columns/2);
    col2_1 = col3 - 1 ;
    
    col4 =  floor((columns/4)*3);
    col3_1 = col4 - 1 ;
    
    row1 = 1;
    row2 = floor(rows/4);
    row1_1 = row2 - 1;
    row3 = floor(rows/2);
    row2_1 = row3 - 1 ;
    row4 =  floor((rows/4)*3);
    row3_1 = row4 - 1 ;
    
     firstBlock = imcrop(imgr, [col1 row1 col1_1 row1_1]);
     subplot(2, 3, 2);
     imshow(firstBlock);
     
    secondBlock = imcrop(imgr, [col1 row2 col1_1 row2_1]);
    subplot(2, 3, 2);
    imshow(secondBlock);
    
    thirdBlock = imcrop(imgr, [col1 row3 col1_1 row3_1]);
    subplot(2, 3, 2);
    imshow(thirdBlock);
    
    fourthBlock = imcrop(imgr, [col1 row4 col1_1 H]);
    subplot(2, 3, 2);
    imshow(fourthBlock);
    
    fifthBlock = imcrop(imgr, [col2 row1 col2_1 row1_1]);
    subplot(2, 3, 2);
    imshow(fifthBlock);
    
    sixthBlock = imcrop(imgr, [col2 row2 col2_1 row2_1]);
    subplot(2, 3, 2);
    imshow(sixthBlock);
    
    seventhBlock = imcrop(imgr, [col2 row3 col2_1 row3_1]);
    subplot(2, 3, 2);
    imshow(seventhBlock);
    
    eighthBlock = imcrop(imgr, [col2 row4 col2_1 H]);
    subplot(2, 3, 2);
    imshow(eighthBlock);
    
    ninthBlock = imcrop(imgr, [col3 row1 col3_1 row1_1]);
    subplot(2, 3, 2);
    imshow(ninthBlock);
    
    tenthBlock = imcrop(imgr, [col3 row2 col3_1 row2_1]);
    subplot(2, 3, 2);
    imshow(tenthBlock);
    
    eleventhBlock = imcrop(imgr, [col3 row3 col3_1 row3_1]);
    subplot(2, 3, 2);
    imshow(eleventhBlock);
    
    twelvethBlock = imcrop(imgr, [col3 row4 col3_1 H]);
    subplot(2, 3, 2);
    imshow(eleventhBlock);
    
    thirteenthBlock = imcrop(imgr, [col4 row1 W row1_1]);
    subplot(2, 3, 2);
    imshow(thirteenthBlock);
    
    fourteenthBlock = imcrop(imgr, [col4 row2 W row2_1]);
    subplot(2, 3, 2);
    imshow(fourteenthBlock);
    
    fifteenthBlock = imcrop(imgr, [col4 row3 W row3_1]);
    subplot(2, 3, 2);
    imshow(fifteenthBlock);
    
    sixteenthBlock = imcrop(imgr, [col4 row4 W H]);
    subplot(2, 3, 2);
    imshow(sixteenthBlock);
    
    
   
    blockArray = {firstBlock, secondBlock,thirdBlock, fourthBlock, fifthBlock, sixthBlock,seventhBlock,eighthBlock, ninthBlock,tenthBlock, eleventhBlock,twelvethBlock,thirteenthBlock, fourteenthBlock, fifteenthBlock,sixteenthBlock     };
   for i=1:length(blockArray)
    imIdx = 8;
    % RESAMPLING PARAMETERS
    resampleRatio = 1.1;
    N = 2;   % window size
    M = 16 % block size
   im  = baseFileName;
   [H,W,~] = size(imgr);
    for k = 1:length(resampleRatio)   
      r = resampleRatio(k);   
   img = double(blockArray{i});       
   % img = imresize(img,[M M],'bilinear');    
    pmap = emresampleN(img,N,'verbose');                  
    periodicitymap = fft2c(pmap);
    
    subplot(2, 3, 3);
    imshow(imgr);
     
   realPeriodicityMap = abs(periodicitymap);
   Ndecimals = 2 ;
   f = 10.^Ndecimals ; 
   realPeriodicityMap= round(f*realPeriodicityMap)/f ;

  fprintf(' realPeriodicityMap');
  disp(realPeriodicityMap);
  
  periodicitymapRow = reshape(realPeriodicityMap, 1, []); 
  %disp(periodicitymapRow);
  
    %disp(fmap);
    % display p-map
    subplot(2, 3, 3);
    imshow(blockArray{i});
    figure;
    
    %subplot(131)
    %imshow(img,[])
    fperiodicitymap = ifft2(periodicitymap);
    subplot(131)
    imshow(abs(rmcenter(fperiodicitymap)),[]);
    
    subplot(132)
    imshow(pmap,[])
    
    subplot(133)
    imshow(abs(rmcenter(periodicitymap)),[]);
    
    
    end    
     
  end