function [R] = zernike_flipxmatrix(zstruct)
jtonmtable = zstruct.jtonmtable;
ncoeff = size(jtonmtable, 1);
R = zeros(ncoeff, ncoeff);
for i=1:size(jtonmtable, 1)
    m = jtonmtable(i, 2);
    if rem(abs(m), 2) == 0 && m < 0
        R(i, i) = -1;
    elseif rem(abs(m), 2) == 1 && m > 0
        R(i, i) = -1;
    else
        R(i, i) = 1;
    end
end
