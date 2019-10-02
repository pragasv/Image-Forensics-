

function localEnergy = calLocalEnergy(energy)
           block_of_image = [0 0];
            % r = 0;
         %for plength = 1: length(energy)
            
          % r = r + energy(plength);
          
          localEnergy = max(block_of_image(:)) ./ sum(block_of_image(:));
           
 end
       
        
        
       



