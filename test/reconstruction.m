
addpath('../shwfs/');
addpath('./data/'); 

load shstruct;
pic = 'Z8-.bmp';
img = double(rgb2gray(imread(pic))) / shstruct.maxinteger;
[zhatrad, er] = shwfs_dai_estimate_rad(img, shstruct, 632.8e-9);
zcs_3d = -[0; zhatrad]; 
z_line = zhatrad;
zstruct = shstruct.dai_zstruct;
dd = linspace(-1, 1, 80);
[xx, yy] =  meshgrid(dd, dd);
zstruct = zernike_cache(zstruct, xx, yy);

sfigure(1);

subplot(2, 2, 1:2);
sel = 1:size(z_line, 1);

plot(sel, z_line, 'Marker', 'x', 'LineWidth', 0.5); 

rms1 = norm(zcs_3d(2:end));
strehl = exp(-rms1.^2);
title(sprintf('strehl=%.3f rms=%.2f norm(er)=%.2f', strehl, rms1, norm(er)));
set(gca, 'XTick', sel);
xlabel('Z_i (Zernike Index)');
ylabel('rad');
grid on;

subplot(2, 2, 3);
zernike_surf(zstruct, zcs_3d); 
zlabel('rad');
shading interp;

subplot(2, 2, 4);
zernike_imagesc(zstruct, zcs_3d);
axis equal;
axis off;
title(sprintf('%d Zernike polynomials', zstruct.ncoeff));