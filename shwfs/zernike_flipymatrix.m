function [R] = zernike_flipymatrix(zstruct)
jtonmtable = zstruct.jtonmtable;
ncoeff = size(jtonmtable, 1);
R = zeros(ncoeff, ncoeff);
for i=1:size(jtonmtable, 1)
    m = jtonmtable(i, 2);
    if m < 0
        R(i, i) = -1;
    else
        R(i, i) = 1;
    end
end
