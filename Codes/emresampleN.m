function [Pmap, varargout] = emresampleN(img,N,varargin)


MAXITER = 100;
EPSILON = 1e-3;
MAXBLOCKS = 3.5e3;
p0 = 1/256;

if(size(img,3)~=1)
    error('Image must be grayscale.')
end

if(nargin>2)
    verbose = (varargin{1}=='verbose');
else
    verbose = 0;
end

wlen = 2*N+1; % window length
cen = floor(wlen^2/2) + 1;  % center element
[height width] = size(img);

% create column image
imcol = im2col(img,[wlen wlen]);
[~,nblocks] = size(imcol);
Y = imcol';
Y(:,cen) = []; % delete center element

% initialize parameters
alpha = rand(1,wlen^2-1)';
alpha = alpha./sum(alpha(:)); % normalize weights
sigma =1;

% extract center pixel of each block
y = img(N+1:end-N,N+1:end-N);
y = y(:);

% select random subset to perform EM
idx_rand = randperm(nblocks);
idx = idx_rand(1:min(MAXBLOCKS,nblocks));

Yt = Y(idx,:);
yt = y(idx,:);




for iter = 1:MAXITER    
    prev = alpha;
    
    if(verbose==1)
        disp(iter)
    end
    
    % E-step
    R = yt - Yt*alpha;  % find residuals
    P = 1/(sigma*sqrt(2*pi)) * exp(-R.^2/(2*sigma.^2)); % find probablities
    w = P./(P+p0);
    
    % M-step                   
    sigma = sqrt( sum(w.*R.^2)/sum(w) );     
    alpha = (Yt'*diag(w)*Yt) \ Yt'*diag(w)*yt;    
    
    if(max(abs(prev-alpha))<EPSILON)
        break;
    end
end

if(verbose==1)    
    fprintf('Number of iterations = %i\n',iter);
    fprintf('sigma = %.5f\n',sigma);
end

Pmap = 1/(sigma*sqrt(2*pi)) * exp(-(y-Y*alpha).^2/(2*sigma.^2));

Pmap = reshape(Pmap,[height-2*N width-2*N]);
%disp(Pmap);

if(nargout==1)
    varargout{1} = alpha;
elseif(nargout==2)
    varargout{1} = alpha;
    varargout{2} = sigma;
elseif(nargout==3)
    varargout{1} = alpha;
    varargout{2} = sigma;
    varargout{3} = iter;
end

