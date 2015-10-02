function [StandardizedSensitivity2_notsorted,StandardizedSensitivity_notsorted,StandardizedSensitivity1_notsorted,  SensitivityMainFactors, IsSensitive_notsorted]=Pareto_GlobalSensitivity_errorbar(Clustering, ParametersValues, ParametersNames, alpha_vector, ColorType)


%cdf_MainFactor(ParametersValues, Clustering, ParametersNames)
[~,StandardizedSensitivity1_notsorted] = dGSA_MainFactors(Clustering,ParametersValues,0, ParametersNames,alpha_vector(1));
[~,StandardizedSensitivity2_notsorted] = dGSA_MainFactors(Clustering,ParametersValues,0, ParametersNames,alpha_vector(3));
[SensitivityMainFactors,StandardizedSensitivity_notsorted,~, IsSensitive_notsorted] = dGSA_MainFactors(Clustering,ParametersValues,0,ParametersNames,alpha_vector(2));

StandardizedSensitivity1=StandardizedSensitivity1_notsorted;
StandardizedSensitivity2=StandardizedSensitivity2_notsorted;
StandardizedSensitivity=StandardizedSensitivity_notsorted;
%% This is to produce Marco's plot


%% Input Parameters
%   - SensitivityValues: vector (NbParams x 1) of the parameter sensitivities
%   - ParametersNames: Parameter names
%   - IsSensitive (optional): vector (NbParams x 1) of 0 (if not sensitive) or 1
%                 (sensitive) to color bars.(By default all bars are of the same color.)


NbParams = length(StandardizedSensitivity);

if NbParams > 10
    TextSize = 10;
else
    TextSize = 12;
end

% Sort from less sensitive to most sensitive
[~, SortedSA] = sort(StandardizedSensitivity(:),'ascend');
StandardizedSensitivity = StandardizedSensitivity(SortedSA);
ParametersNames = ParametersNames(SortedSA);
IsSensitive = IsSensitive_notsorted(SortedSA);
StandardizedSensitivity2=StandardizedSensitivity2(SortedSA);
StandardizedSensitivity1=StandardizedSensitivity1(SortedSA);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MINMIN%%%%%%%%%%%%%
%p_values=min(p_values');
% p_values=mean(p_values');
% p_values=p_values';
% p_values=p_values(SortedSA);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p_values=mean(p_values,2);
% p_values=p_values(SortedSA); % Sort p_value
% Abort comment out for original, comment out the above 4
% [~, SortedSA] = sort(SensitivityValues(:),'ascend');
% SensitivityValues = SensitivityValues(SortedSA);
% ParametersNames = ParametersNames(SortedSA);
% IsSensitive = IsSensitive(SortedSA);

%% Define Color

switch ColorType
    
    case 'jet'
        
        C=jet;
        nC=size(C,1);
        C=flipud(C);
    case 'RB'
        
        C2=jet(64);C=C2*0; % Initialize
        
        C(:,1)=linspace(0,1,size(C,1))'; % Blue
        C(:,3)=linspace(1,0,size(C,1))'; % Red
  
       % C(:,1)=linspace(C2(1,1),C2(end,1),size(C,1))'; % Blue
       % C(:,3)=linspace(C2(1,3),C2(end,3),size(C,1))'; % Red
        nC=size(C,1); % Default, nC=64        
        %C=flipud(C); % Start from red
        
    otherwise
        error('Enter correct values')
        
end
%% Assgin the color


%% Pick up pvalues

%p_values=min(p_values, 2);
%ColorIndex=zeros(length(p_values),3);
%ColorIndex=zeros(length(p_values),1);

%% Define the color before the for loop - linear regularization
% for k=1:length(p_values)
%     
%     sorted_threshold_p_values=sort([threshold;p_values(k)],'descend');
%     idx_color=find(sorted_threshold_p_values==p_values(k));
%     
%     
%     ColorIndex(k,:)=C(idx_color,:);
%     
% end
% 
% ColorIndex=ColorIndex(SortedSA);
%IsSensitive = IsSensitive(SortedSA);

%%
if nargin == 5  % bar are colored
    
    %C2 = [0.8,0,0];
    %C1 = [0,0,0.8];
    
    %     C1 = [0.8,0,0];
    %     C2 = [0,0,0.8];
    h1 = []; h2 = [];
    figure
    axes('FontSize',TextSize,'fontweight','b');  hold on;
    for i = 1:NbParams
        delta_n=StandardizedSensitivity1(i)-StandardizedSensitivity2(i); % define delta_n
        if StandardizedSensitivity(i)<1-delta_n/2
            ColorVector=C(1,:); % Blue
        elseif StandardizedSensitivity(i)>1+delta_n/2
            ColorVector=C(end,:); % Red
        else
            higher=1+delta_n/2;
            lower=1-delta_n/2;
            ratio_pvalue=(StandardizedSensitivity(i)-lower)/(higher-lower);
            ColorVector=C(floor(nC*ratio_pvalue)+1,:);
            
        end
        
        colormap(C);
        if IsSensitive(i) == 1
            h1 = barh(i,StandardizedSensitivity(i),'FaceColor',ColorVector,'BarWidth',0.8,'LineStyle','-','LineWidth',2);
            % h1 = barh(i,SensitivityValues(i),'FaceColor',C2,'BarWidth',0.8,'LineStyle','-','LineWidth',2);
        else
            h2 = barh(i,StandardizedSensitivity(i),'FaceColor',ColorVector,'BarWidth',0.8,'LineStyle','-.','LineWidth',2);
            %  h2 = barh(i,SensitivityValues(i),'FaceColor',C1,'BarWidth',0.8,'LineStyle','-.','LineWidth',2);
        end
        
        %   Example:
%      x = 1:10;
%      y = sin(x);
%      e = std(y)*ones(size(x));
%      herrorbar(x,y,e)
        herrorbar(1,i,delta_n/2);
        
        
        
        
        
    end
    set(gca,'YTick',1:NbParams)
    set(gca,'YTickLabel',ParametersNames)
    plot([1 1], [0 NbParams+1],'m','LineWidth',3);
    box on; ylim([0 NbParams+1]);
    h3=colorbar; caxis([0 .1]);%caxis([lower,higher]); %set(h3,'YDir','reverse');
    %if ~isempty(h1) && ~isempty(h2)
    %     legend([h1,h2],'Sensitive','NotSensitive','location','SouthEast')
    %  elseif isempty(h1)
    %   legend(h2,'NotSensitive','location','SouthEast')
    %  elseif isempty(h2)
    %  legend(h1,'Sensitive','location','SouthEast')
    %  end
    
else
    figure
    axes('FontSize',TextSize,'fontweight','b');  hold on;
    barh(StandardizedSensitivity);
    box on;
    set(gca,'YTick',1:NbParams)
    set(gca,'YTickLabel',ParametersNames)
    ylim([0 NbParams+1])
end

end

