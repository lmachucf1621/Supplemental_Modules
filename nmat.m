% FUNCTION: [n0, n2, nfunc] = nmat(mtype, lambda)
% 2 required inputs + 1 optional input:
% (1)  type of material (i.e. 'FS2' for fused silica),
% (2)  wavelength or range of wavelengths.
% Wavelength in [m]
% n0 unitless
% n2 in [cm^2/W]
function [n0, n2, nfunc] = nmat(mtype, lambda)

    % Units and universal constants
    cm = 10^-2;
    um = 10^-6;
    W = 1;

    % Convert wavelength's unit to um
    lambda = lambda /um;

    %{
        All Sellmeier equations are fitting functions; thus, they're only
        valid for a specific spectral range. In the database, modified
        piecewise Sellmeier equations are implemented to take into account
        their validity.
    %}

    % Generate physical properties of the material(s)
    switch cell2mat(lower(num2cell(mtype)))
        case 'znse'
            % Linear refractive index - chi(1)
            B1 = 4.45813734;
            C1 = 0.200859853;
            B2 = 0.467216334;
            C2 = 0.391371166;
            B3 = 2.89566290;
            C3 = 47.1362108;
            nfunc =@(x) sqrt(1 + B1./(1 - (C1./x).^2) + B2./(1 - (C2./x).^2) + B3./(1 - (C3./x).^2)) .* (x >= 0.54 & x <= 18.2);
            n0 = nfunc(lambda);

            % Nonlinear refractive index - chi(3)
            n2 = 4e-14 *(cm^2/W);
        case 'fs2'
            % Linear refractive index - chi(1)
            B1 = 0.6961663;
            C1 = 0.0684043;
            B2 = 0.4079426;
            C2 = 0.1162414;
            B3 = 0.8974794;
            C3 = 9.896161;
            nfunc =@(x) sqrt(1 + B1./(1 - (C1./x).^2) + B2./(1 - (C2./x).^2) + B3./(1 - (C3./x).^2)) .* (x >= 0.21 & x <= 6.7);
            n0 = nfunc(lambda);

            % Nonlinear refractive index - chi(3)
            n2 = 6.2e-16 *(cm^2/W);
        case 'tisa'
            % Linear refractive index - chi(1) - for o waves
            B1 = 1.4313493;
            C1 = 0.0726631;
            B2 = 0.65054713;
            C2 = 0.1193242;
            B3 = 5.3414021;
            C3 = 18.028251;
            nfunc.no =@(x) sqrt(1 + B1./(1 - (C1./x).^2) + B2./(1 - (C2./x).^2) + B3./(1 - (C3./x).^2)) .* (x >= 0.2 & x <= 5);
            n0.no = nfunc.no(lambda);

            % Linear refractive index - chi(1) - for e waves
            B1 = 1.5039759;
            C1 = 0.0740288;
            B2 = 0.55069141;
            C2 = 0.1216529;
            B3 = 6.5927379;
            C3 = 20.072248;
            nfunc.ne =@(x) sqrt(1 + B1./(1 - (C1./x).^2) + B2./(1 - (C2./x).^2) + B3./(1 - (C3./x).^2)) .* (x >= 0.2 & x <= 5);
            n0.ne = nfunc.ne(lambda);

            % Nonlinear refractive index - chi(3)
            n2 = 3e-16 *(cm^2/W);
        otherwise
            disp([mtype ' cannot be found in the database!'])
            return
    end

end