function F = rmcenter(Fc,varargin)
% F = RMCENTER(FC) deletes the DC component and high pass filters 
%   the frequency map
%   'ideal' uses idea high pass filter 
%   'cosine' (default) used raised cosine filter
% Last updated December 10, 2011 

opt = 0;

if(nargin>1)
    opt = (varargin{1}=='ideal');
end

[Nx,Ny] = size(Fc);
[Kx Ky] = meshgrid(linspace(-1,1,Ny),linspace(-1,1,Nx));
R = sqrt(Kx.^2+Ky.^2);

if(opt==1)
    % remove center for display
    rad = 0.1; %from 0-1, radius of high-pass filter        
    H = (R>rad);    
else
    % raise cosine filter
    H = 0.5 - 0.5.*cos(4*pi*R);
    H(R>0.25) = 1;    
end

F = Fc.*H;
F(round(Nx/2)+1,round(Ny/2)+1)=0;