function [R] = zernike_rotmatrix(zstruct, alpha)
jtonmtable = zstruct.jtonmtable;
ncoeff = size(jtonmtable, 1);
R = zeros(ncoeff, ncoeff);
for i=1:size(jtonmtable, 1)
    n = jtonmtable(i, 1);
    m = jtonmtable(i, 2);
    if m == 0
        R(i, i) = 1;
    elseif m > 0
        inminm = find(sum(abs(jtonmtable - ...
            kron(ones(ncoeff, 1), [n, -m])), 2) == 0);
        assert(numel(inminm) == 1);
        R(i, i) = cos(m*alpha);
        R(i, inminm) = sin(m*alpha);
    elseif m < 0
        inminm = find(sum(abs(jtonmtable - ...
            kron(ones(ncoeff, 1), [n, -m])), 2) == 0);
        assert(numel(inminm) == 1);
        R(i, inminm) = -sin(abs(m)*alpha);
        R(i, i) = cos(abs(m)*alpha);
    end
end
end
