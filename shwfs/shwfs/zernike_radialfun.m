function y = zernike_radialfun(radialtablerow)

radc = radialtablerow(1);
rads = radialtablerow(2);

if radc == 0 && rads == 0
    y = @(x) ones(size(x));
elseif radc ~= 0
    y = @(x) cos(radc.*x);
elseif rads ~= 0
    y = @(x) sin(rads.*x);
else
    throw(MException('VerifyOutput:IllegalInput', 'FIXME'));
end

end
