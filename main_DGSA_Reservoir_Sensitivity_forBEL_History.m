%% Distance based global sensitivity analysis - Application to reservoir responses
% Part1: Compute main/conditional effects of Prior models

% Author : Jihoon Park (jhpark3@stanford.edu)
% Date : 17 May 2016

clear all; close all; fclose('all'); rng('default');
%% 0. Add directories for path
addpath(genpath(pwd))

%% 1. Specify inputs for DGSA. 
addpath(genpath(pwd))

% Loading the BEL data struct

% History
prior_path = 'Z:/Projects/BM/Code/Data/BM_NFA_first/Prior_data_OilRate.mat';
load(prior_path);

% taking history out
Data = Prior_Property_data.data(2:end,:); % we can keep the original ordering for history
Time = Prior_Property_data.HistoricalTime;
plot(Time,Data(1,:))


%% eucledian distance
DGSA.D = squareform(pdist(Data));


%% delta time weighted euclidean distance (studio)

 [ DM ] = ComputeWeightedEuclideanDistance( Data, Time );

 DGSA.D = DM;

%% reading the parameters

parameter_path = 'Z:/Projects/BM/Code/Data/Parameters_History_short.csv';

Parameters = csvimport(parameter_path);

DGSA.ParametersNames = Parameters(1,:);
% removing the line with the names
DGSA.ParametersValues = Parameters(2:end,:);

% number of observations
DGSA.N=size(DGSA.ParametersValues,1);

% converting the geomodels to a number
GeomodelsParam = grp2idx(DGSA.ParametersValues(:,1));

% recombining the parameters (geomodels plus others)

Params = cell2mat(DGSA.ParametersValues(:,2:end));
DGSA.ParametersValues = [GeomodelsParam, Params];

%% 4. Compute & display main effects

% 4.1 Inputs for clustering and display options.
DGSA.Nbcluster=3; % # of clusters
DGSA.MainEffects.Display.ParetoPlotbyCluster=1; % if true, main effects over cluster will be displayed with Pareto plot.
DGSA.MainEffects.Display.StandardizedSensitivity='CI'; 

% if 'CI', the confidence interval will be overlapped on the Pareto plot
% if 'Pareto', Pareto plots will be displayed only
% if 'None' No plot will be generated for standardd main effects
% (default)

% 4.2 Compute main effects from DGSA.
SigLevel_CI=[.95,.9,1]; % This is needed only when you want to display confidence intervals
                        % If you do not need to display confidence intervals,set DGSA.MainEffects.Display.StandardizedSensitivity='Preto' or 'None'     

% 4.3 Perform clustering
DGSA.Clustering=kmedoids(DGSA.D,DGSA.Nbcluster,10); % In this example, K medoid clustering is applied.

% 4.4 Compute Main Effects
DGSA=ComputeMainEffects(DGSA,SigLevel_CI); % If you use Pareto plot or do not want to display main effects, remove SigLevel_CI, otherwise it shows an error.

%% Display cdfs

cdf_MainFactor(DGSA.ParametersValues, DGSA.Clustering, DGSA.ParametersNames,{'owc','oilvis'}); % In this example, CDFs for 'owc' and 'oilvis' will be displayed.
%% 5. Compute & Display conditional effects

% 5.1 Specify additional variables to estimate conditional effects.

DGSA.ConditionalEffects.NbBins=3*ones(1,length(DGSA.ParametersNames));

% 5.2 Compute conditional effects

rng('default'); 
DGSA=ComputeConditionalEffects(DGSA);

% 5.3 Display conditional effcts

% Speicify the method to display standardized conditional effects.
DGSA.ConditionalEffects.Display.SensitivityByClusterAndBins=1; % if true, display pareto plots to visualize sensitivities by bins/clusters. 
DGSA.ConditionalEffects.Display.StandardizedSensitivity='Hplot'; % If omitted Pareto plot will be used. However, this is not recommended when there are lots of parameters

% Visualize conditional effects
DisplayConditionalEffects(DGSA,DGSA.ConditionalEffects.Display.StandardizedSensitivity)

% 5.4 Display class condtional CDFs
cdf_ConditionalEffects('owc','kvkh',DGSA,1)

%% 6. Check the response

% Use MDS plot to check the result of clustering
ClusterColor=DisplayMDSplot(DGSA.D, DGSA.Clustering);

% Specify texts for plots
PlotLabels.xlabtxt='Time (day)'; PlotLabels.ylabtxt='WWPT (stb)'; 
PlotLabels.xlimits=[0, 7300]; PlotLabels.ylimits=[0 7E7];

% Visualize dynamic response by clusters
dynamicbycluster(DGSA.Clustering,PriorResponses, ClusterColor,PlotLabels);


%% Save all variables for futher application
%save('VariablesSaved/DGSA_Completed.mat');
%save('VariablesSaved/DGSA_Spatial_Completed.mat');