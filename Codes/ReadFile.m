clc;
close all;
clear all;

% Specify the folder where the files live.
myFolder = 'F:\Project\Test\resampling\resampling\Original\ucid\';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
  uiwait(warndlg(errorMessage));
  return;
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, '*.tif'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
  baseFileName = theFiles(k).name;
  fullFileName = fullfile(myFolder, baseFileName);
  
  fprintf(1, 'Now reading %s\n', fullFileName);
  % Now do whatever you want with this file name,
  % such as reading it in as an image array with imread()
  imageArray = imread(fullFileName);
  %imshow(imageArray);  % Display image.
  drawnow; % Force display to update immediately.
  
  A = imread(fullFileName);
  B= imread('Original/ucid/ucid00144.tif');
  B= imresize(B,0.2)

C = imfuse(A,B)

  
end
