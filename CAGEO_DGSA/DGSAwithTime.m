function Sensitivity2time=DGSAwithTime(nbclusters,responses, ParametersValues, ParametersNames, tgrid)
%% dGSA evolving with time - This is 1D
Sensitivity2time=[]; % intialize
NbParams=size(ParametersValues,2);
%nbclusters=3;
for i=1:size(responses,2)
    responses_i=responses(:,1:i);
   
    d_i=pdist(responses_i);
    
    Clustering=kmedoids(d_i,nbclusters,10);
   [~,StandardizedSensitivity_i] = dGSA_MainFactors(Clustering,ParametersValues,0,ParametersNames, .95);
   Sensitivity2time(:,i)=StandardizedSensitivity_i;
    
    %Sensitivity2time(:,i)=15*ones(1,15);%StandardizedSensitivity_i;
    
end
%% Plotting

LineSeries={'b','r','k','m','--b','--r','--k','--m',':b',':r',':k',':m'};
figure
for k=1:NbParams
    plot(tgrid, [0,Sensitivity2time(k,:)],LineSeries{k},'LineWidth',2); hold on
    
end
legend(ParametersNames,'Location','EastOutside');
xlim([0 7300]);ylim([0 6]);xlabel('Time(Day)'); ylabel('Sensitivitty');
hold off


end