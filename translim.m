% FUNCTION: [tmat, It] = translim(lmat, S, tmax, npts)
% 4 required inputs:
% (1) wavelength (1D) matrix in [nm],
% (2) power spectrum,
% (3) upper limit of the time window [fs],
% (4) number of gridpoints.
% tmat in [fs]
function [tmat, It] = translim(lmat, S, tmax, npts)

    % Speed of light in nm/fs
    c = 299.792458;

    % Compute the conversion factor - wavelength-to-frequency scaling
    S = sqrt(S .* lmat.^2./(2 * pi * c));
    clf
    plot(lmat, S)
    % Field discretization in TIME space in fs
    dt = tmax/npts;
    tmat = dt .* (-npts/2 : npts/2-1).';

    % Field discretization in SPECTRAL space in nm
    nf = 2^5 * npts;
    df = 1/(nf * dt);
    fmat = df .* (-nf/2 : nf/2-1).';

    % Place the input power spectrum on the new spectral grid
    Sp = interp1(c./lmat(end:-1:1), S(end:-1:1), fmat, 'linear');
    Sp(isnan(Sp) == 1) = 0;
    %Sp = Sp - 154.2;
    %Sp(Sp < 0) = 0;
    %clf
    %plot(fmat, Sp)
    fmat(1:100)
    % Compute the pulse intensity at transform limit
    It = fft(Sp);
    It = It([end/2+1:end 1:end/2])./max(It);

    % Crop the time window
    It = abs(It(1 + nf/2 + (-npts/2 : npts/2-1))).^2;

end