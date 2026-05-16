function [deltas, moved] = shwfs_plot_deltas_quiver(img, shstruct, ref2)

sc = 1e3;
k = sc*shstruct.camera_pixsize;

centres = k*shstruct.centres;
[deltas, moved] = shwfs_get_deltas(img, shstruct);

if exist('ref2', 'var')
    ref = ref2;
else
    ref = zeros(size(deltas));
end

pdeltas = deltas - ref;
quiver(centres(: ,1), centres(:, 2), ...
    pdeltas(:, 1), pdeltas(:, 2));
axis equal;
xlabel('mm');
ylabel('mm');
title(num2str(mean(deltas)));

end

