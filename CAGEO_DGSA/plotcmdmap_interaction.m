function plotcmdmap_interaction(Xd,SensitivityMainFactor,ScaleFactor, H0accMain,ParametersNames)
%%% Coded by Jihoon Park



figure
hold on
for k=1:size(Xd,1)
    
%     h=plot(Xd(k,1), Xd(k,2), 'o', 'MarkerSize', SensitivityMainFactor(k)*ScaleFactor, 'LineWidth', 1.2, ...
%         'MarkerFaceColor',[0.7 0.7 0.7], 'MarkerEdgeColor','k');

if H0accMain(k)==1
    colorv='r';
else
    colorv='b';
end

filledCircle(Xd(k,:),SensitivityMainFactor(k)/ScaleFactor,100,colorv);axis('equal');
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

end
