%%
% Author : Jihoon Park
% Date : 2015 7 11
%%
clear all; close all; fclose('all'); rng('default');
%% Input
nbclusters=3; % Number of clusters to use in DGSA
alpha_vector=[.9,.95,1];
ColorType='RB';
ScaleFactorSymBubble=3;dims=2;ScaleFactorHplot=30;

%% Load values of model parameters & dynamic responses
parameters=LoadRealizations('Realizations',3);
load('responses.mat'); 
load('DistanceMatrix.mat'); % Load distance Matrix D
parameters.NbWell=3; % Number of wells
parameters.NbParam=length(parameters.names_variables);
NbBins=3*ones(1,parameters.NbParam); 



%% DGSA - sinlge way sensitivity 
Clustering=kmedoids(D,nbclusters,10);
[StandardizedSensitivity.LowPvalues,StandardizedSensitivity.MediumPvalues,StandardizedSensitivity.HighPvalues, SensitivityMainFactors, StandardizedSensitivity.IsSensitive]=...
    Pareto_GlobalSensitivity_errorbar(Clustering, parameters.values, parameters.names_variables, alpha_vector,ColorType);


%% DGSA - interactions
Parameters.InteractionsNames=create_interactions_name(parameters.names_variables);
rng('default');
[SensitivityInteractions,GlobalSensitivityInteractions,IsInteractionSens] = dGSA_Interactions(Clustering,...
       parameters.values,Parameters.InteractionsNames,NbBins);

%% Symmetric bubble plot

CoordBubblePlot=SymBubblePlot(GlobalSensitivityInteractions, parameters.names_variables, ScaleFactorSymBubble, StandardizedSensitivity.MediumPvalues, StandardizedSensitivity.IsSensitive);

%% Hplot
CoordHPlot=DisplayHplot(GlobalSensitivityInteractions,StandardizedSensitivity.MediumPvalues,parameters.NbParam,dims, parameters.names_variables, ScaleFactorHplot);

%% Visulazation of Clustering Result
ClusterColor=DisplayMDSplot(D, Clustering);
dynamicbycluster(Clustering,ClusterColor,parameters.NbWell,WWPTbyWell,100);

%% Save variables
save('DGSAresults.mat');
