% FUNCTION: A = baseline(A, noiselim, forders)
% 3 required inputs:
% (1) 1D data,
% (2) absolute noise level or range of data considered to be noise,
% (3) fitting orders (i.e. [1 1 1] to include 0th, 1st, and 2nd terms).
function A = baseline(A, noiselim, forders)

    % Set the X axis
    X = (1 : numel(A)).';

    % Set the background noise's limit
    if numel(noiselim) == 1             % noise's amplitude
        noise = A(A < noiselim);
        inoise = (1 : numel(noise)).';
    else                                % noise's range
        noise = A(noiselim);
        inoise = X(noiselim);
    end

    % Compute the baseline by curve fitting
    base = [1.^inoise inoise inoise.^2]\noise .* forders.';

    % Subtract the baseline from the input data
    A = A - (base(1) + base(2) .* X + base(3) .* X.^2);
    A(A < 0) = 0;

end