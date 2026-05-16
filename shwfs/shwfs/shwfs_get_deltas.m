function [deltas, moved] = shwfs_get_deltas(img, shstruct)

centres = shstruct.ord_centres;
moved = shwfs_get_centres(img, shstruct, shstruct.centroid);

deltas = moved - centres;

end


