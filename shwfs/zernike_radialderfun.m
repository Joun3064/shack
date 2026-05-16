function y = zernike_radialderfun(radialtablerow)

radc = radialtablerow(1);
rads = radialtablerow(2);

if radc == 0 && rads == 0
    y = @(x) 0*x;
elseif radc ~= 0

    y = @(x) -sin(radc.*x).*radc;
elseif rads ~= 0

    y = @(x) cos(rads.*x).*rads;
else
    throw(MException('VerifyOutput:IllegalInput', 'FIXME'));
end

end
