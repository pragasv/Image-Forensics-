
   
 function result = YourFunction(block_of_image)
   result = double(max(block_of_image(:))) ./ sum(double(block_of_image(:)));  