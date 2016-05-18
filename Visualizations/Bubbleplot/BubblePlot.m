function Xd=BubblePlot(GlobalSensitivityInteractions, ParametersNames, ScaleFactor,...
    StandardizedSensitivity, IsSensitive,Fontsizes)
% The function displays bubble plot to display condtional effects. 
% Author: Jihoon Park (jhpark3@stanford.edu)
% Date: March, 2015
%
% Input:
% GlobalSensitivityInteractions: a vector of standardized conditional effects
% ParametersNames: a cell of names of parameters
% ScaleFactor: a scalar to scale the size of bubble. The size of bubble is proportional to main effects. Higher values give smaller bubble.
% StandardizedSensitivity: a vector of standardized main effect
% IsSensitive: a logical vector to show the result of bootstrap hypothesis tests. If 1, then reject H0 (sensitive)
% Fontsizes: Fontsize at bubble plot
%
% Ouput 
% Xd: opitional, a matrix (# of Parameters x 2) containing coordinates of bubbles.

N=length(ParametersNames);
D=GetDistMatrixfromInterSens(GlobalSensitivityInteractions,N); % In the bubble plot, the distance between parameters are defined as the inverse of the average of conditional effects. 

% Multi-Dimensional Scaling (MDS) using distance d
rng(123433);
Xd_ = cmdscale(D);
dims = 2;
Xd = Xd_(:,1:dims);

figure
hold on
for k=1:size(Xd,1)
    

if IsSensitive(k)==1
    colorv='r';
else
    colorv='b';
end

filledCircle(Xd(k,:),StandardizedSensitivity(k)/ScaleFactor,100,colorv);axis('equal');
alpha(.5);
    
    text(Xd(k,1),Xd(k,2),ParametersNames{k},'HorizontalAlignment','center','Fontsize',Fontsizes);

end
hold off
grid off

set(gca,'XTickLabel',{''})
set(gca,'YTickLabel',{''})
set(gcf,'color','w');box on; set(gca,'LineWidth',3);

end