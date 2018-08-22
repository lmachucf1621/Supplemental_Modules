% FUNCTION: [Xp, Yp] = interpdat(X, Y, npts)
% 3 required inputs:
% (1) X data,
% (2) Y data,
% (3) number of points on the new grid
function [Xp, Yp] = interpdat(X, Y, npts)

    % Re-discretize the input data
    dx = (X(end) - X(1))/npts;
    Xp = X(1) + dx .* (0 : npts-1).';

    % Place the input data on the new grid
    Yp = interp1(X, Y, Xp, 'linear');
    Yp(isnan(Yp) == 1) = 0;

end