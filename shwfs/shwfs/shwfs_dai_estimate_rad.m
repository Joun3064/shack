function [z, er, s, se, rer] = shwfs_dai_estimate_rad(img, shstruct, ...
    lambda)

flen = shstruct.flength;
ps = shstruct.camera_pixsize;

t = ps*shwfs_get_deltas(img, shstruct);
s = t(:);

zrad = (1/flen)*(shstruct.dai_pE1*s);

se = flen*(shstruct.dai_E1)*zrad;
er = s - se;
rer = (1e-6 + s - se)./(1e-6 + s);

z = ((2*pi)/(lambda))*zrad;

end

