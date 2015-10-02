clear all; close all; fclose('all');
load('DGSAresults');load('Responses_PUR');load('responses_OnlyTwoSens.mat');
parameters.tgrid=365:365:7300;parameters.idx=2;
QuantileLevel=[.1,.5,.9];

%% Net interactions
Parameter2Reduce='scen';
idx_Parameters2Reduce=find(ismember(parameters.names_variables,Parameter2Reduce));
DisplyFlag=1; % if true, disply a figure
%% Net interaction sensitivity for single parameter
InteractionsNames=create_interactions_name(parameters.names_variables);

%% Net interaction sensitivity for all parameters
[ConditionalSensitivityMatrix, MaxSensBinNum]=...
MakeStackedConditional(SensitivityInteractions,idx_Parameters2Reduce,InteractionsNames, parameters.names_variables,DisplyFlag); 
%ParetoAllModelReduction(MakeSumConditional(SensitivityInteractions,1),ParametersNames, StandardizedSensitivity)
ParetoAllModelReduction(SensitivityInteractions,StandardizedSensitivity.MediumPvalues,parameters.names_variables)

%% Comparision of Responses
figure_response_start=200;
CompareResponses(WWPTbyWell,WWPT_PUR,WWPT_OnlyTwoSens,parameters.tgrid,parameters.idx,QuantileLevel,figure_response_start)
