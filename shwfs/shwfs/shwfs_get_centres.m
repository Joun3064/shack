function centres = shwfs_get_centres(img, shstruct, ...
    myfuncentroid)

nspots = shstruct.nspots;
ordgrid = shstruct.ord_sqgrid;

centres = zeros(nspots, 2);

for ith=1:nspots
    cc = ordgrid(ith, :);

  
    if (shstruct.use_bg)
        subimage = img(cc(3):cc(4), cc(1):cc(2)) - ...
            shstruct.sh_flat_bg(cc(3):cc(4), cc(1):cc(2));
    else
        subimage = img(cc(3):cc(4), cc(1):cc(2));
    end
    
    iimin = min(min(subimage));
    iimax = max(max(subimage));
    level = (iimax - iimin)*shstruct.percent + iimin;

    dd = myfuncentroid(subimage, level);
   
    centres(ith, :) = [cc(1)+dd(2)-1, cc(3)+dd(1)-1];
end

end
