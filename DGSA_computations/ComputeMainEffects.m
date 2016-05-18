function DataStructMainEffects=ComputeMainEffects(DataStruct,alpha,ColorType)
% This function computes/display main effects from DGSA.
% Author: Jihoon Park (jhpark3@stanford.edu) and Celine
% Scheidt(scheidtc@stanford.edu)

% Input:
% DataSturc : Data structure containing every information. e.g.) 'Prior' has values of parameters and corresponding responses from Prior.
% alpha(optional): 1-significance level for bootstrap hypothesis testing. If confidence interval is used for visualization of main effects, this should be length of 3
% Otherwise, it should be scalar. If not specified, .95 will be used as default.
% ColorType (optional): If a confidence interval is displayed, you can
% specify the types of color. If it is 'RB', the bar is colored red and
% blue. If it is 'jet' it uses 'jet' color object from Matlab. If not
% specified, 'RB' is used as default.

% e.g.) SigLevel=[.9, .95, .1]. The length of bar is based on the 2nd
% element (.95 in this example). 

% Output: 
% DataStructMainEffects: Results of Main effects are added to DataStruc
% DataStructMainEffects.MainEffects.SensitivitybyCluster : Main effects by clusers
% DataStructMainEffects.MainEffects.SensitivityStandardized : Main effects averaged over clusters
% DataStructMainEffects.Clustering: Results from kmedoid clustering. See kmedoids.m for details.

%% Create variables
DataStructMainEffects=DataStruct;
if nargin<2
    alpha=.95;
end

    
%% 1. Check the visualization method.
if ~DataStruct.MainEffects.Display.StandardizedSensitivity
    DataStruct.MainEffects.Display.StandardizedSensitivity='None'; % Default is not to visualize sensitivities
end

switch DataStruct.MainEffects.Display.StandardizedSensitivity

    case 'CI'
        if length(alpha)~=3 
            error('In order to disply confidence interval, alpha should be a vector of length 3')
        end
        
        [~,idx]=sort(alpha);
        
        if ~all(idx==[2,1,3])
            error('In order to disply confidence interval, alpha(3)>alpha(1)>alpha(2)')
        end
        
               
        
    case 'Pareto'
        if ~isscalar(alpha)
            error('Significane level should be scalar for Parteo plot only')
        end
    case 'None'
        if ~isscalar(alpha)
            error('Significane level should be scalar when sensitivities not displayed')
        end
    otherwise
        error('Enter the right type of display method');
        
end
    

%% 2. Create variables 
D=DataStruct.D; % Distance Matrix
ParametersValues=DataStruct.ParametersValues; % Values of Parameters
nbclusters=DataStruct.Nbcluster; % # of clusters (classes)
ParametersNames=DataStruct.ParametersNames;



%% 3. Perform Clsutering for DGSA
Clustering=kmedoids(D,nbclusters,10);



%% 4. Compute Main Effects

L1MainFactors = L1normMainFactors(Clustering,ParametersValues); % evaluate L1-norm
L1MainFactors=repmat(L1MainFactors,1,1,length(alpha));

BootMainFactors = BootstrapMainFactors(ParametersValues,Clustering,2000,alpha);  % bootstrap procedure

SensitivityMainFactors = L1MainFactors./BootMainFactors; % normalization 
SensitivitybyCluster=SensitivityMainFactors(:,:,1);
StandardizedSensitivity = mean(SensitivityMainFactors,2); 


%% 5. Hypothetis test: H0=1(reject, so sensitive) if at least one value > 1 (per cluster)
H0accMain = any(SensitivitybyCluster >=1,2); 



%% 6. Save Main effects to Data Structure
SensitivityStandaridzed=StandardizedSensitivity(:,:,1);
SensitivitybyCluster=SensitivityMainFactors(:,:,1);
DataStructMainEffects.MainEffects.SensitivitybyCluster=SensitivitybyCluster;
DataStructMainEffects.MainEffects.SensitivityStandardized=SensitivityStandaridzed;
DataStructMainEffects.Clustering=Clustering;
DataStructMainEffects.MainEffects.H0accMain=H0accMain;

%% 7. Display main effects.

% 3.1 Sensitivity by cluster.
if DataStruct.MainEffects.Display.ParetoPlotbyCluster % display main effects by cluster  
        ParetoMainFactors(SensitivitybyCluster,ParametersNames);    
end

% 3.2 Display Standardized Sensitivity

switch DataStruct.MainEffects.Display.StandardizedSensitivity
    case 'CI'
        if nargin<3
        ColorType='RB';
        end
        Pareto_GlobalSensitivity_CI(StandardizedSensitivity, H0accMain, ParametersNames,ColorType);
        
    case 'Pareto'
        
        Pareto_GlobalSensitivity(SensitivityStandaridzed,ParametersNames,H0accMain);
  
        
end
    

end