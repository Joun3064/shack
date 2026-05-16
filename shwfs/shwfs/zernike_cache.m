function zstruct = zernike_cache(zstruct, xx, yy)

[th, rh] = cart2pol(xx, yy);
zstruct = zernike_cache_pol(zstruct, th, rh);
zstruct.xx = xx;
zstruct.yy = yy;

end
