function [ret] = centroid(im, thr)

assert(isa(im, 'double'));

if (nargin < 2)
    thr = 0;
end

[w, h] = size(im);

[yy, xx] = meshgrid(1:h, 1:w);
im(im < thr) = 0;
sumx = sum(reshape(xx.*im, numel(xx), 1));
sumy = sum(reshape(yy.*im, numel(yy), 1));
mass = sum(im(:));

ret = [sumx/mass, sumy/mass];

end
