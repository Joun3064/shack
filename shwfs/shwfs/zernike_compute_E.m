function E = zernike_compute_E(zstruct, shstruct)

pupil_radius_m = shstruct.pupil_radius_m;
sa_radius_m = shstruct.sa_radius_m;
ncoefs = zstruct.ncoeff;
nspots = shstruct.nspots;
ord_centres = shstruct.ord_centres;
pixsize = shstruct.camera_pixsize;

radtab = zstruct.radialtable;
azimtab = zstruct.azimtable;

E = zeros(2*shstruct.nspots, ncoefs);

sac = shstruct.pupil_centre_pix;
rbar = sa_radius_m/pupil_radius_m;

kk = pupil_radius_m/(pi*(sa_radius_m^2));

for i=1:nspots
    dx1dx2 = (ord_centres(i, :) - sac)*pixsize;
    r = norm(dx1dx2)/(pupil_radius_m);

    gamma = atan2(-dx1dx2(2), dx1dx2(1));
    if r > 1
        throw(MException('VerifyOutput:IllegalInput', ...
            'Aperture radius is too small, use a larger pupil_radius_m'));
    end
    
    for zi=2:ncoefs
        radtabrow = radtab(zi, :);
        azimtabrow = azimtab(zi, :);
        
        [ey, ex] = zernike_compute_EyEx(...
            radtabrow, azimtabrow, r, gamma, rbar);

        E(i, zi) = kk*ex;
        E(i + nspots, zi) = -kk*ey;
    end
end

end
