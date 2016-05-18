
%
% Distance-based generalized sensitivity analysis (dGSA)
% Evaluation of sensitivity of the conditioanl effects
 
% Author: Celine Scheidt
% Date: August 2013

% Updated by Jihoon Park (jhpark3@stanford.edu)
% Date: 14 May 2016
%   - Use data structures
%   - Separate computations and visualizations
%   - Display the conditioning parameter computed

function DGSA_ConditionalEffects = ...
   ComputeConditionalEffects(DGSA,alpha)%(Clustering,ParametersValues,ParametersNames,NbBins,alpha)

DGSA_ConditionalEffects=DGSA;

Clustering=DGSA.Clustering;
ParametersValues=DGSA.ParametersValues;
NbBins=DGSA.ConditionalEffects.NbBins;
ParametersNames=DGSA.ParametersNames;

%% Input Parameters
%   - Clustering: Clustering results
%   - ParametersValues: matrix (NbModels x NbParams) of the parameter values
%   - InteractionsNames: List containing the interaction names to be displayed on the y-axis
%   - NbBins: Vector containing the number of bins per parameter
%   - alpha: (optional): alpha-percentile (by default, alpha = 0.95) for
%            the bootstrap

%% Output Parameters 
%   - NormalizedInteractions: 4D array (NbParams x NbParams-1 x NbClusters x max(NbBins)) containing the sensitivity
%                             values for each interaction, each class and each bin.
%   - StandardizedSensitivityInteractions: vector containing the standardized measure of sensitivity
%                                          for each interaction
%   - H0accInter: vector containing the result of bootstrap hybothesis
%   testing. If 1, rejcet H0 (sensitive)

NbParams = size(ParametersValues,2);
NbClusters = size(Clustering.medoids,2);

if nargin < 2; alpha = .95; end

% Evaluate the normalized conditionnal interaction for each parameter, each
% class and each bin
L1Interactions = NaN(NbParams,NbParams-1,NbClusters,max(NbBins));  % array containing all the Interactions 
BootInteractions = NaN(NbParams,NbParams-1,NbClusters,max(NbBins));  

for params = 1:NbParams
    fprintf('Computing sensitivity conditional to %s...\n',ParametersNames{params});
    L1InteractionsParams = L1normInteractions(ParametersValues,params,Clustering,NbBins(params));
    L1Interactions(params,:,:,1:NbBins(params)) = L1InteractionsParams(:,:,1:NbBins(params));
    BootInteractionsParams = BootstrapInteractions(ParametersValues,params,Clustering,NbBins(params),2000,alpha);
    BootInteractions(params,:,:,1:NbBins(params)) = BootInteractionsParams(:,:,1:NbBins(params));
    NormalizedInteractions = L1Interactions./BootInteractions;
end


% Measure of conditional interaction sensitivity per class
SensitivityPerClass = nanmean(NormalizedInteractions,4);

% Average measure of sensitivity over all classes 
SensitivityOverClass = nanmean(SensitivityPerClass,3);

% Display the results
%ParetoInteractions(NormalizedInteractions,InteractionsNames,NbClusters,NbBins)

% Hypothesis test: Ho = 1 if at least one value > 1 (per cluster and per bin)
SensitivityPerInteraction = reshape(permute(NormalizedInteractions,[2,1,4,3]),[],max(NbBins)*NbClusters);
H0accInter = any(SensitivityPerInteraction >=1,2);

StandardizedSensitivityInteractions = reshape(SensitivityOverClass',1,[]);

DGSA_ConditionalEffects.ConditionalEffects.SensitivityByClusterandBins=NormalizedInteractions;
DGSA_ConditionalEffects.ConditionalEffects.StandardizedSensitivity=StandardizedSensitivityInteractions;
DGSA_ConditionalEffects.ConditionalEffects.H0accConditional=H0accInter;
DGSA_ConditionalEffects.ConditionalEffects.Names_ConditionalEffects=CreateNames_ConditionalEffect(ParametersNames);

 
end



