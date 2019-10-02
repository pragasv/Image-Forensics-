clc;
clear all;
close all;

%result = blockproc(img, [57 57], aux_fun, 'TrimBorder', false)

img = imread('E:\seniors projects\nipuni akki project - IT\Test\resampling\resampling\kodim\kodim03.png');
%img = imread('Original\ucid\ucid00020.tif');
img = rgb2gray(img);
img= double(img);
aux_fun = @(block_info) YourFunction2(block_info.data);
result = blockproc(img,[256 256], aux_fun,'BorderSize',[0 0]);
periodicitymap = result;


subplot(2, 3, 3);
imshow(img);

 realPeriodicityMap = abs(periodicitymap);
 Ndecimals = 2 ;
 f = 10.^Ndecimals ; 
 realPeriodicityMap= round(f*realPeriodicityMap)/f ;

  %fprintf(' realPeriodicityMap');
  %disp(realPeriodicityMap);
  
 periodicitymapRow = reshape(realPeriodicityMap, 1, []);

 n = 4;
 m=2;
 sum1 = 0; 
 
 [sortedVal, sortedInds] = sort(periodicitymapRow,'descend');
  top4 = (abs( sortedVal(1:4)));

  
for ii = 1 : n
    sum1 = sum1 + top4(ii);
end

  %fprintf('sum1 : ');
  %disp(sum1);

  f1 = (m*sqrt(sum1));
  %fprintf('Feature 01 : ');
  %disp(f1);
 
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %Extracting second feature
 


%maxCoeff =  max(periodicitymapRow(:));
[ max_value, max_index ] = max( periodicitymapRow );
%maxCoeff =  max(periodicitymapRow);
%disp(max_value );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting Feature 3
%fimg = fft2(im);
fimgss = periodicitymap(2:end,2:end);    %skip the zero-order components
absfimg = abs(fimgss);
meanabs = mean(absfimg(:));
[sortdiff, diffidx] = sort(abs( absfimg(:) - meanabs ), 'descend');
ssfar4 = diffidx(1:4);
f13frabs = sortdiff(1)+sortdiff(2)+sortdiff(3)+sortdiff(4); 
f3 = f13frabs ;                               %sum1 of the abs of the frequency differences
f13frorig = sum(fimgss(ssfar4));  %sum of the complex frequency differences
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting Feature 4

localEnergyMap = periodicitymap.*conj(periodicitymap);

aux_fun_1 = @(block_info) YourFunction(block_info.data);
result_1 = blockproc(localEnergyMap, [64 64], aux_fun_1,'BorderSize',[0 0]);
result2 = sum(sum(result_1));
f4 = (((100*result2).^m)/100);
%fprintf('feature 04');
%disp(f4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extracting Feature 5

R= 0;
energy = periodicitymap.*conj(periodicitymap);
%disp('Total energy :');
%disp(energy);
       
%for plength = 1: length(energy)
  %  R = R + energy(plength);
%end
R = sum(sum(energy));
%fprintf('R value :');
%disp(R);

energymapRow = reshape(energy, 1, []);
[sortedVal, sortedInds] = sort(energymapRow,'descend');
topVal = sortedVal(1:1);
        
%fprintf('max value :');
%disp(topVal);
        
R = ( topVal / R);
       
f5 = ((10000*R).^m) /100;
%fprintf('Feature 05 : ');
%disp(f5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%feature06
f6 = (f3-f4);
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%create feature array

feature_arrayO = [f1,f3,f4,f5,f6];
%fprintf('Original Values : ');

feature_array = [f1,f3,f4,f5,f6];
for  le = 1:length(feature_array) 
    %disp(feature_array(le));
      
end
fprintf('##############################');
fprintf('\n');


minVal = min(feature_array);
%disp(minVal);
feature_array=feature_array - minVal;

maxVal = max(feature_array);
feature_arrayN = (feature_array / maxVal);

%disp( feature_arrayN);

%feature_arrayN[1]*100000;
dlmwrite('ResampledFeatures.csv',feature_arrayO,'-append');
%dlmwrite('NonResampledFeaturesNormalized.csv',feature_arrayN','-append');
 

    