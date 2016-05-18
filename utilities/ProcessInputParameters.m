function DataStruct=ProcessInputParameters(FileName,DataStruct)
% The function proceses Monte Carlo results of Parameters to use in DGSA
%
% Author: Jihoon Park (jhpark3@stanford.edu)
% Date: 12 May 2016

% Input :
% FileName: The file that contains name of parameters and values from Monte
% Carlo simulations

% DataStruct: variable of class struct that contains all related information

% Output:
% DataStruct: The program will add 1) Values of parameters 2) Names of Parameters

%% 1. Import data
DataImported=importdata(FileName);
%% 2. Save data at DataStruct
DataStruct.ParametersNames=DataImported.textdata(1,2:end); % Names of parameters
DataStruct.ParametersValues=DataImported.data; % Values of Parameters
DataStruct.N=size(DataStruct.ParametersValues,1); % Sample size

end