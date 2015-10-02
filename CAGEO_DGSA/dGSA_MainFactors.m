%
% Distance-based generalized sensitivity analysis (dGSA)
% Evaluation of sensitivity of the main factors only
% Pareto plots are used to display the resuls
 
% Author: Celine Scheidt
% Date: August 2012

function [SensitivityMainFactors,StandardizedSensitivity, MinGlobSensParaNum, H0accMain] = dGSA_MainFactors(Clustering,ParametersValues,NeedFigure,ParametersNames,alpha)

%% modified from dGSA_MainFactors
%%% Get rid of plots, and get H0accMain
%%%% In output, this gives the index of parameter of minimum Global
%%%% sensitivity. If it is 2, then it is y. See line 44

%% Input Parameters
%   - Clustering: Clustering results
%   - ParametersValues: matrix (NbModels x NbParams) of the parameter values
%     (numerical values should be provided, even for discrete parameters)
%   - ParametersNames: list containing the names of the parameters 
%   - alpha: (optional): alpha-percentile (by default, alpha = 0.95) for
%            the bootstrap

%% Output Parameters 
%   - SensitivityMainFactors: Matrix containing the normalized L1norm for each parameter (1st dim) and
%   each cluster (2nd dim).
%   - StandardizedSensitivity: Vector containing the standardized measure of sensitivity for each parameter

if nargin < 5; alpha = .95; end

L1MainFactors = L1normMainFactors(Clustering,ParametersValues); % evaluate L1-norm
BootMainFactors = BootstrapMainFactors(ParametersValues,Clustering,2000,alpha);  % bootstrap procedure

SensitivityMainFactors = L1MainFactors./BootMainFactors; % normalization 
StandardizedSensitivity = mean(SensitivityMainFactors,2); % standardized measure of sensitivity 

% Display the results
if NeedFigure
    ParetoMainFactors(SensitivityMainFactors,ParametersNames);
end

% Hypothesis test: Ho = 1 if at least one value > 1 (per cluster)
H0accMain = any(SensitivityMainFactors >=1,2);
%Pareto_GlobalSensitivity(StandardizedSensitivity,ParametersNames,H0accMain);
%%% We need to see Pareto plot for global sensitivity 
[~,MinGlobSensParaNum]=min(StandardizedSensitivity);

end