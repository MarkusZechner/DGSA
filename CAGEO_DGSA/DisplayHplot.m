function H=DisplayHplot(GlobalSensitivityInteractions,StandardizedSensitivity, NbParams,dims, ParametersNames, ScaleFactor)
X=GetAsymmetricDistanceHplot(GlobalSensitivityInteractions,NbParams);
%X=GetAsymmetricDistanceHplot(GlobalSensitivityInteractions,NbParams, StandardizedSensitivity, .1); % .1 is the MinSensitivity so if .1 0 to 1.1 scale.
S=cov(X); % Get the covariance matrix.

[q, lambda_vec]=eig(S); lambda_extract=diag(lambda_vec);
q1=q(:,end); q2=q(:,end-dims+1); lambda1=sqrt(lambda_extract(end)); lambda2=sqrt(lambda_extract(end-1));
H=[lambda1*q1, lambda2*q2];
%plot(H(:,1),H(:,2),'.');
n=size(H,1);H1=H(1:n/2,:); H2=H(n/2+1:n,:);
figure; hold on
H0accMain=zeros(size(H,1),1);
H0accMain(1:n/2)=1;
Fontsizes=12;
%plotcmdmap_interaction_Hplot(H,[StandardizedSensitivity;StandardizedSensitivity],ScaleFactor, H0accMain,[ParametersNames,ParametersNames],Fontsizes)

StandardizedSensitivity=[StandardizedSensitivity;StandardizedSensitivity];
ParametersNames=[ParametersNames,ParametersNames];
for k=1:size(H,1)
    
    %     h=plot(Xd(k,1), Xd(k,2), 'o', 'MarkerSize', SensitivityMainFactor(k)*ScaleFactor, 'LineWidth', 1.2, ...
    %         'MarkerFaceColor',[0.7 0.7 0.7], 'MarkerEdgeColor','k');
    
    if H0accMain(k)==1
        colorv='g';%colorv='r'; % Change to green in
    else
        colorv='m'; % Change it blue to cyan
    end
    
    filledCircle(H(k,:),StandardizedSensitivity(k)/ScaleFactor,100,colorv);axis('equal');
    alpha(0.5);
    %h=plot(Xd(k,1), Xd(k,2), 'o', 'MarkerSize', SensitivityMainFactor(k)*ScaleFactor, 'LineWidth', 1.2, ...
    % 'MarkerEdgeColor','k');
    %aa=get(h);
    %patch
    %h=plot(Xd(k,1), Xd(k,2), 'o', 'MarkerSize', SensitivityMainFactor(k)*ScaleFactor, 'LineWidth', 1.2, ...
    %'MarkerFaceColor',[0.7 0.7 0.7], 'MarkerEdgeColor','k');
    
    text(H(k,1),H(k,2),ParametersNames{k},'HorizontalAlignment','center','Fontsize',Fontsizes, 'Fontweight','Bold');
    
end
hold off
grid off

%set(gca,'LineWidth',3)
set(gca,'XTickLabel',{''})
set(gca,'YTickLabel',{''})
set(gcf,'Color','w');
set(gca,'LineWidth',2);
box on; set(gca,'LineWidth',3);


hold off


lambda_extract=flipud(lambda_extract);
lambdasq_seq_sum=cumsum(lambda_extract.^2);
lamdasq_sum=lambda_extract'*lambda_extract;
lambdasq_seq_sum=lambdasq_seq_sum/lamdasq_sum;
lambdasq_seq_sum=[0;lambdasq_seq_sum];
indexi=0:length(lambdasq_seq_sum)-1;figure;
plot(indexi,lambdasq_seq_sum,'LineWidth',3);
xlim([0,10]);
set(gca,'XTick',[0:length(lambdasq_seq_sum)]);
set(gca,'Fontsize',12);
set(gca,'Fontsize',12);
xlabel('Dim','Fontsize',14);
ylabel('Goodness of fit','Fontsize',14);

end
