function [shstruct] = shwfs_calibrate(...
    shstruct, filename, sh_flat, sh_flat_bg)

sfigure(1);
subplot(1, 2, 1);
imagesc(sh_flat_bg);
axis image;
axis off;
colorbar();
title('background');
subplot(1, 2, 2);
imagesc(sh_flat);
axis image;
axis off;
colorbar();
title('reference SH image');
iimin = min(sh_flat(:));
iimax = max(sh_flat(:));
fprintf('[min, max] = [%.2f %.2f]\n', iimin, iimax);

shstruct.sh_flat = sh_flat;
shstruct.sh_flat_bg = sh_flat_bg;
if exist('scflat', 'var')
    shstruct.scflat = scflat;
end
ask_confirm('continue?');

close all;
clc;
shstruct = shwfs_make_coarse_grid(shstruct, 1);

close all;
clc;
shstruct = shwfs_make_fine_grid(shstruct, 1);

close all;
clc;
shstruct = shwfs_make_dai(shstruct, 1);

fprintf('saved %s\n', filename);
save(filename, 'shstruct');

end
