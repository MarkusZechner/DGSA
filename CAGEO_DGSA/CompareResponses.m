function CompareResponses(Original,AfterPUR,TwoSensOnly,tgrid,idx,QuantileLevel,figstart)


ResponsesOriginal=GetdynamicResponses(Original,tgrid,idx);
ResponsesPUR=GetdynamicResponses(AfterPUR, tgrid, idx); 
ResponsesTwoSensOnly=GetdynamicResponses(TwoSensOnly, tgrid, idx); 
NbProdWell=size(Original,1);

for k=1:NbProdWell
    figure(k+figstart)
    Quantiles_k=QuantileComputation(ResponsesOriginal(:,:,k),QuantileLevel);
    Quantiles_k_PUR=QuantileComputation(ResponsesPUR(:,:,k),QuantileLevel);
    Quantiles_k_TwoSensOnly=QuantileComputation(ResponsesTwoSensOnly(:,:,k),QuantileLevel);
   % Quantiles_est = QuantileComputation(Responses_mean(:,:,k),[0.1,0.5,0.9],Clustering);
    
    ResponsesOriginal_k=ResponsesOriginal(:,:,k);
    %figure
    hold on
    for k2=1:size(ResponsesOriginal_k,1)
        plot([0,tgrid], [0,ResponsesOriginal_k(k2,:)],'Color',[.7,.7,.7]);    
    
    end
    
    add0=[0;0;0];
    h1=plot([0,tgrid], [add0,Quantiles_k],'-.k','LineWidth',4);
    %hold on
    h2=plot([0,tgrid], [add0,Quantiles_k_PUR],'-r','LineWidth',3);
    h3=plot([0,tgrid], [add0,Quantiles_k_TwoSensOnly],'-b','LineWidth',3);      
    xlim([0 tgrid(end)]);ylim([0 7E7]);
    %ylim([0 1E5]);
    xlabel('Time (day)');ylabel('WWPT(stb)');
    title(['Prod ',num2str(k+1)])%', Cluster #=',num2str(nbclusters_dgsa)]);
    %title(['Well',num2str(k+1),', Cluster #=',num2str(nbclusters_dgsa)]);
    legend([h1(1),h2(1), h3(1)],'Initial Models','Reduced','Two Most Sens. Para. Only', ...
        'location','NorthWest');
    hold off
%Quantiles_est = QuantileComputation(FullResponse,[0.1,0.5,0.9],Clustering);
end


end