% main_compareDGSA_Sobol.m
% Author: Jihoon Park (jhpark3@stanford.edu)
% Date: 16 May 2016

% The script is to compare sensitivities from DGSA and Sobol's method.
% For details, consult with the paper written by Park et al. (2016) -
% DGSA: a matlab toolbox for distance-based generalized sensitivity analysis for geoscientific computer experiments
clear all; close all; fclose('all');
%%
timegrid=0:365:7300; N_Models=1000;nbcluster=3;
%% Load Sobol related parameters
load('FWPT.mat'); Sobol_responses=FWPT; clear FWPT;
DGSA_responses=Sobol_responses(1:N_Models,:);
DGSA=ProcessInputParameters('SobolParameters.dat');
%% Run DGSA over time
DGSA.Nbcluster=nbcluster;
MainEffects_over_time=DGSA_over_time(DGSA,DGSA_responses,timegrid);

%% Compute & display Sobols' indicies
First_order_Sobol=SobolSensitivity(timegrid,Sobol_responses,N_Models,DGSA.ParametersNames);

save('VariablesSaved/DGSAandSobol_comparision.mat');
