function [fdm, cdm, bdm] = femat(dord, eord)

    % Construct a Taylor expansion matrix for CDM
    cm = -eord/2 : eord/2;
    T = cm.^((0 : eord).');

    % Construct the CDM coefficient matrix
    cdm = zeros(eord+1, 1);
    cdm(dord+1) = factorial(dord);
    cdm = round(T\cdm, eord).';

    % Construct a Taylor expansion matrix for FDM
    cm = 0 : eord;
    T = cm.^((0 : eord).');

    % Construct the FDM coefficient matrix
    fdm = zeros(eord+1, 1);
    fdm(dord+1) = factorial(dord);
    fdm = round(T\fdm, eord).';

    % Construct the BDM coefficient matrix
    bdm = (-1)^mod(dord, 2) .* fdm(end:-1:1);

end