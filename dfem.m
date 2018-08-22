% FUNCTION: dfemat = dfem(npts, dord, eord)
% 3 required inputs:
% (1) number of points,
% (2) derivative order (i.e. 2 for 2nd derivative),
% (3) error order (i.e. 4 for 4th error order O(dx^4)).
% *The constructed matrix uses a combination of forward, backward, and central
% difference FEMs to achieve the best accuracy. No boundary conditions are
% applied.
% *The scaling factor is not applied. It's determined by the step size - dx.
% For example, dfemat * dx^-2 is used for 2nd derivative.
% References:
% (1) https://en.wikipedia.org/wiki/Finite_difference_coefficient
% (2) http://web.media.mit.edu/~crtaylor/calculator.html
function dfemat = dfem(npts, dord, eord)

    % Check the error order
    if mod(eord, 2) == 1
        eord = eord + 1;
        disp('This function only takes even error orders because it uses a combination of forward, backward, and central difference FEMs!')
        fprintf('Error order of %1.f is used ...\n', eord)
    end

    % Compute coefficient matrices
    [fdm, cdm, bdm] = femat(dord, eord);

    % Construct the FEM matrix from its coefficient matrices
    dfemat = spdiags(cdm .* ones(npts, 1), -eord/2 : eord/2, npts, npts);
    dfemat(1:eord/2, 1:eord+1) = fdm .* ones(eord/2, 1);
    dfemat(end-eord/2+1:end, end-eord:end) = bdm .* ones(eord/2, 1);

end