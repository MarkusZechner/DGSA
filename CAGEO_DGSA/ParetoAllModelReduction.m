%
% This function creates a bar chart showing for each parameter, the L1-norm
% for each cluster.
 
% Author: Celine Scheidt
% Date: August 2012


function ParetoAllModelReduction(SensitivityInteractions, GlobalSens, ParamsNames)

%% Input Parameters
%   - MatrixSum: matrix (NbParams x NbClusters) of the L1-norm values
%   - ParamsNames: Parameter names to be displayed on the y-axis

[NbParms, ~, NbClusters, NbMaxBins]=size(SensitivityInteractions);
SensitivityInteractionOverClass=nanmean(SensitivityInteractions, 3); % Average over cluster

SensitivityInteractionSumInter=sum(SensitivityInteractionOverClass,2);
MatrixSum=zeros(NbParms, NbMaxBins);

%p_conditional=SensitivityInteractionOverClass(ConditionalParameterNum,:,:,:); 
% p is that p from s(p_i | p_j)
% Next thing to do, is to make the below output as a simple matrix
%[~, NumParamMinus1, ~, NbBinsP_Conditional]=size(p_conditional);

%p_condi2Matrix=zeros(NbBinsP_Conditional,NumParamMinus1); % InitializeTheMatrix

for k=1:NbMaxBins
    
    MatrixSum(:,k)=SensitivityInteractionSumInter(:,:,:,k);    % The reason why doing this is that in the stacked bar graph, stacked
    % value should be written in row vector of each matrix. For example
    % Item1 : 1 2 4 comprises one bar.
    
    
end





[NbParams NbClusters] = size(MatrixSum);


% Sort from less sensitive to most sensitive
%StandardizedSensitivity = mean(MatrixSum,2); 

%Delete sorting
[~, SortedSA] = sort(GlobalSens,'ascend');
MatrixSum = MatrixSum(SortedSA,:);
ParamsNames = ParamsNames(SortedSA);

figure;
axes('FontSize',12,'fontweight','b');  hold on;
h0 = barh(1:NbParams,MatrixSum,0.8,'group','LineWidth',1.5);

P=findobj(h0,'type','patch');
C = definecolor(NbClusters);
for n=1:length(P) 
    set(P(n),'facecolor',C(n,:),'LineWidth',1.5);
end

%plot([1 1],[0.5 NbParams+0.5],'r','LineWidth',3) 
set(gca,'YTick',1:NbParams)
set(gca,'YTickLabel',ParamsNames)
box on
xlim([4.5,7]);
legend('Low','Med','High','Location','NorthEastOutside');
end


% This function defines the bar colors
function C = definecolor(NbClusters)
    Cs = colormap(jet(124));
    Ds = floor(linspace(1,size(Cs,1),NbClusters));
    C = Cs(Ds,:);
    %%%% added  %%%
  %  C=flipud(C);
end