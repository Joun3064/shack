function [Ey, Ex] = ...
    zernike_compute_EyEx(radrow, azimrow, r, gamma, rbar)

assert(r >= 0 && r < 1);
assert(rbar > 0 && rbar < 1);

rhoindefint1 = polyint([polyder(radrow) 0]);
rhoindefint2 = polyint(radrow);

if r > rbar
    thetas = gamma + ...
        [acos(sqrt(r^2 - rbar^2)/r), - acos(sqrt(r^2 - rbar^2)/r)];

    theta_a = min(thetas);
    theta_b = max(thetas);
    assert(theta_b > theta_a);

    rho_a = @(x) r*cos(x - gamma) - ...
        sqrt(r^2.*cos(x - gamma).^2 - (r^2 - rbar^2));
    rho_b = @(x) r*cos(x - gamma) + ...
        sqrt(r^2.*cos(x - gamma).^2 - (r^2 - rbar^2));
else
    theta_a = 0;
    theta_b = 2*pi;

    rho_a = @(x) 0*x;
    rho_b = @(x) r*cos(x - gamma) + ...
        sqrt(r^2.*cos(x - gamma).^2 - (r^2 - rbar^2));
end


rhoint1a = @(x) polyval(rhoindefint1, rho_a(x));
rhoint1b = @(x) polyval(rhoindefint1, rho_b(x));
rhoint2a = @(x) polyval(rhoindefint2, rho_a(x));
rhoint2b = @(x) polyval(rhoindefint2, rho_b(x));

psi = zernike_radialfun(azimrow);
psider = zernike_radialderfun(azimrow);

integrandx = @(x) ...
    (rhoint1b(x) - rhoint1a(x)).*psi(x).*cos(x) - ...
    (rhoint2b(x) - rhoint2a(x)).*psider(x).*sin(x);

integrandy = @(x) ...
    (rhoint1b(x) - rhoint1a(x)).*psi(x).*sin(x) + ...
    (rhoint2b(x) - rhoint2a(x)).*psider(x).*cos(x);

Ex = integral(integrandx, theta_a, theta_b);
Ey = integral(integrandy, theta_a, theta_b);

end

