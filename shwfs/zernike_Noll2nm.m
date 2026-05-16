function [n, m, nollstr, nmstr] = zernike_Noll2nm(zstruct, noll)
n = zstruct.jtonmtable(noll, 1);
m = zstruct.jtonmtable(noll, 2);

if nargout >= 3
    nollstr = sprintf('$Z_{%d}$', noll);
end
if nargout >= 4
    nmstr = sprintf('$Z_{%d}^{%d}$', n, m);
end
end
