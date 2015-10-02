clear all; close all; fclose('all');

%% Input
load('FWPT.mat');
nbclusters=3;NModels_in_DGSA=1000;tgrid=0:365:7300;
parameters=LoadRealizations('SobolParameters',3);
GlobalSens_with_time=DGSAwithTime(nbclusters,FWPT(1:NModels_in_DGSA,:), parameters.values, ...
    parameters.names_variables,tgrid);
SobolIndex=SobolSensitivity(tgrid,FWPT,NModels_in_DGSA,parameters.names_variables);

save('DGSA_and_Sobol_completed.mat');