function Xd=SymBubblePlot(GlobalSensitivityInteractions, ParametersNames, ScaleFactor, StandardizedSensitivity, IsSensitive)
N=length(ParametersNames);
D=GetDistMatrixfromInterSens(GlobalSensitivityInteractions,N);
% Multi-Dimensional Scaling (MDS) using distance d
rng(123433);
Xd_ = cmdscale(D);
dims = 2;
Xd = Xd_(:,1:dims);
%ScaleFactor=3;
%plotcmdmap_interaction(Xd,SensitivityMainFactor,ScaleFactor, H0accMain,ParametersNames)
% ParametersNames={'oilvis','dtmax','kvkh','mflt1','mflt2','mflt3','mflt4',...
%     'oilexp','owc','sorw','swc','watexp','scen','prop','size'};








%plotcmdmap_interaction(Xd,StandardizedSensitivity,ScaleFactor, IsSensitive,ParametersNames)

figure
hold on
for k=1:size(Xd,1)
    
%     h=plot(Xd(k,1), Xd(k,2), 'o', 'MarkerSize', SensitivityMainFactor(k)*ScaleFactor, 'LineWidth', 1.2, ...
%         'MarkerFaceColor',[0.7 0.7 0.7], 'MarkerEdgeColor','k');

if IsSensitive(k)==1
    colorv='r';
else
    colorv='b';
end

filledCircle(Xd(k,:),StandardizedSensitivity(k)/ScaleFactor,100,colorv);axis('equal');
alpha(.5);
        %h=plot(Xd(k,1), Xd(k,2), 'o', 'MarkerSize', SensitivityMainFactor(k)*ScaleFactor, 'LineWidth', 1.2, ...
        % 'MarkerEdgeColor','k');
    %aa=get(h);
        %patch 
        %h=plot(Xd(k,1), Xd(k,2), 'o', 'MarkerSize', SensitivityMainFactor(k)*ScaleFactor, 'LineWidth', 1.2, ...
        %'MarkerFaceColor',[0.7 0.7 0.7], 'MarkerEdgeColor','k');
    
    text(Xd(k,1),Xd(k,2),ParametersNames{k},'HorizontalAlignment','center','Fontsize',14);

end
hold off
grid off

%set(gca,'LineWidth',3)
set(gca,'XTickLabel',{''})
set(gca,'YTickLabel',{''})




set(gcf,'color','w');box on; set(gca,'LineWidth',3);

end