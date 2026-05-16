function [shstruct] = shwfs_make_dai(shstruct, wait)

ncoefs = shstruct.dai_n_zernike;
zstruct = zernike_table(ncoefs);

% 【步驟一】直接取用未過濾的參考平面光點座標，計算出絕對的參考光瞳中心
shstruct.pupil_centre_pix = mean(shstruct.ord_centres, 1);
subapradius_m = shstruct.sa_radius_m;

% 【步驟二】計算或取得參考平面的光瞳半徑
if ~isfield(shstruct, 'pupil_radius_m')
    dists = shstruct.ord_centres - ...
        kron(ones(shstruct.nspots, 1), shstruct.pupil_centre_pix);
    [~, i] = sort(sqrt(sum(dists, 2).^2));
    shstruct.pupil_radius_m = norm(shstruct.ord_centres(i(end), :) - ...
        shstruct.pupil_centre_pix)*shstruct.camera_pixsize + ...
        shstruct.sa_radius_m;
end

% 【步驟三】依據剛才確定的「參考平面光瞳中心與半徑」進行過濾
r_pix = shstruct.pupil_radius_m / shstruct.camera_pixsize;
distances = sqrt(sum((shstruct.ord_centres - shstruct.pupil_centre_pix).^2, 2));
valid_idx = distances <= r_pix;

% 將結構更新為僅含光瞳內子孔徑的狀態
shstruct.ord_centres = shstruct.ord_centres(valid_idx, :);
shstruct.ord_sqgrid = shstruct.ord_sqgrid(valid_idx, :);
shstruct.nspots = sum(valid_idx);

% --- 後續繪圖與矩陣計算 (自動套用過濾後的子孔徑) ---
sfigure(18);
imagesc(shstruct.sh_flat); axis image; axis off; hold on;
l = linspace(0, 2*pi);
r_subap = subapradius_m/shstruct.camera_pixsize;

for i=1:shstruct.nspots
    c = shstruct.ord_centres(i, :);
    cc = shstruct.ord_sqgrid(i, :);
    plot(c(1), c(2), 'oy');
    plot(c(1) + r_subap*cos(l), c(2) + r_subap*sin(l), 'y');
    rectangle('Position', [cc(1), cc(3), cc(2)-cc(1)+1, cc(4)-cc(3)+1], 'LineWidth', 1, 'EdgeColor','y');
    text(c(1), c(2), sprintf('  %d', i), 'Color', 'w');
end

% 標示參考平面決定的光瞳中心與邊界
c_pupil = shstruct.pupil_centre_pix;
plot(c_pupil(1), c_pupil(2), 'xm', 'MarkerSize', 13);
plot(c_pupil(1) + r_pix*cos(l), c_pupil(2) + r_pix*sin(l), 'y');
title('Subapertures Inside Reference Pupil');

fprintf('wait, computing matrices...\n');
E = zernike_compute_E(zstruct, shstruct); % 矩陣大小會自動與有效光點數同步
fprintf('   done!\n');

shstruct.dai_E1 = E(:, 2:end);
shstruct.dai_pE1 = pinv(E(:, 2:end));
shstruct.dai_zstruct = zstruct;

if exist('wait', 'var') && wait
    ask_confirm('continue?');
end

end