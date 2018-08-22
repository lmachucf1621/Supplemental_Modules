% FUNCTION: [X, Y] = specpro(fdir, sdir, xrange, varargin)
% 3 required inputs + 1 optional input:
% (1)   path to the datafile,
% (2*)  save path,
% (3*)  wavelength range of interest (i.e. [xmin xmax] to set the minimum and maximum wavelengths),
% (4)   columns of the datafile (i.e. [1 3] to select 1st and 3rd columns of the datafile).
% Unit of wavelength is set by the data
% *Enter [] if not specified
function [X, Y] = specpro(fdir, sdir, xrange, varargin)
%#ok<*NASGU>

    % Explicit variables
    dat = [];

    % Import the raw data
    load(fdir, 'dat')

    % Process the measured power spectrum
    if isempty(varargin)
        [X, Y] = deal(dat(:, 1), dat(:, 2));
    else
        cols = varargin{1};
        [X, Y] = deal(dat(:, cols(1)), dat(:, cols(2)));
    end

    % Select the spectrum of interest
    if isempty(xrange)
        index = 1 : numel(X);
    else
        index = X > xrange(1) & X < xrange(2);
    end
    X = X(index);
    Y = Y(index);

    % Remove baseline of the measured power spectrum
    Y = baseline(movmean(Y, 2^3), 1.02 .* max([Y(1) Y(end)]), [1 0 0]);

    % Export the processed power spectrum
    spec = [X, Y./max(Y)];
    if isempty(sdir)
        return
    else
        save([sdir '-spectrum.mat'], 'spec', '-v6');
        save([sdir '-spectrum.asc'], 'spec', '-ascii');
    end

end