% FUNCTION: [] = dat2mat(fdir, varargin)
% 1 required input + 1 optional input:
% (1) path to the datafile,
% (2) 1 (delete original files) or 0 (do nothing).
function [] = dat2mat(fdir, varargin)
%#ok<*NASGU>

    % Path to the working directory
    cd(fdir)

% TXT TO MAT

    % Create the working directory
    txt = dir('.\*.txt');

    % Convert each 'txt' file into its corresponding 'mat' file
    for i = 1 : numel(txt)
        % Get the file's name
        [~, fname, ~] = fileparts(txt(i).name);

        % Load the 'txt' file
        dat = importdata(txt(i).name);
        try
            dat = dat.data;
        catch
        end

        % Save data to a 'mat' file
        save([fname '.mat'], 'dat', '-v6')
    end

% ASC TO MAT

    % Create the working directory
    asc = dir('.\*.asc');

    % Convert each 'asc' file into its corresponding 'mat' file
    for i = 1 : numel(asc)
        % Get the file's name
        [~, fname, ~] = fileparts(asc(i).name);

        % Load the 'asc' file
        dat = importdata(asc(i).name);

        % Save data to a 'mat' file
        save([fname '.mat'], 'dat', '-v6')
    end

% CSV TO MAT

    % Create the working directory
    csv = dir('.\*.csv');

    % Convert each 'csv' file into its corresponding 'mat' file
    for i = 1 : numel(csv)
        % Get the file's name
        [~, fname, ~] = fileparts(csv(i).name);

        % Load the 'csv' file
        dat = importdata(csv(i).name);
        try
            dat = dat.data;
        catch
        end

        % Save data to a 'mat' file
        save([fname '.mat'], 'dat', '-v6')
    end

% CLEAN UP

    if isempty(varargin)
        return
    else
        if ~isempty(txt)            % clear all 'txt' files
            delete(txt(:).name)
        elseif ~isempty(asc)        % clear all 'asc' files
            delete(asc(:).name)
        elseif ~isempty(csv)        % clear all 'csv' files
            delete(csv(:).name)
        else
            return
        end
    end

end