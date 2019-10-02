
function label = classifyImages()

load ImageFeaturesPredict2.csv

t = ImageFeaturesPredict2(1:end,:);



CompactMdl = loadCompactModel('SVMImageData'); 

label = predict(CompactMdl,t); 

%if label==0
  %  fprintf('Non-Resampled');
%end

%if label==1
  %   fprintf('Resampled');
%end



end
