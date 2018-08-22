% FUNCTION: [x0, dx] = halfwidth(X, Y, amthres, varargin)
% 3 required inputs + 1 optional input:
% (1) X data,
% (2) Y data,
% (3) threshold value (i.e. 0.5 for HWHM, 1/e for HW1/eM, or 1/e^2 for HW1/e^2M),
% (4) 1 (full width) or 0 (half width).
function [x0, dx] = halfwidth(X, Y, amthres, varargin)

    % Compute the signal's amplitude at threshold
    amthres = amthres * max(Y);
    imax = find(Y == max(Y));

    % Compute the given signal's half/full width
    if isempty(varargin)
        % Half width
        x0 = interp1(Y(1:imax), X(1:imax), amthres, 'linear');
        dx = x0;
    else
        % Lower bound
        x0 = interp1(Y(1:imax), X(1:imax), amthres, 'linear');

        % Upper bound
        x1 = interp1(Y(imax:end), X(imax:end), amthres, 'linear');

        % Full width
        dx = abs(x1 - x0);
    end

end