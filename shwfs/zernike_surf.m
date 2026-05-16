function [] = zernike_surf(zstruct, c)
surf(zstruct.xx, zstruct.yy, zernike_eval(zstruct, c));
xlabel('y');
ylabel('x');
end
