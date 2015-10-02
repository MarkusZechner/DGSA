function dynamicbycluster(Clustering,C,NbProd,Well,figstart)
%tgrid=365:365:7300;
legendtext=cell(1,length(Clustering.medoids));
   
for j=1:NbProd
   Well_Prod_h=Well(j,:);
   figure(j+figstart);
   title(['Prod ',num2str(NbProd)]);
   %legend_str={};
   for k=1:length(Clustering.medoids)
    %   legend_str{k}=['Cluster',num2str(k)];
       idx=find(Clustering.T==k);
       data_h=Well_Prod_h(:,idx);
       legendtext{k}=sprintf('Cluster %i',k);
       

       for i=1:length(data_h)
           
           data_h2=data_h{i};
           %data_h=cell2mat(data_h);
           time_h=data_h2(:,1);
           dynamic_h=data_h2(:,2);
           h_h=plot(time_h,dynamic_h,'Color',C(k,:));

           hold on
       end
       h(k)=h_h;
       
   end
   
   
   

   legend(h,legendtext,'Location','northwest');
   xlim([0 7300]);ylim([0 7E7]);  
   title(['Prod ',num2str(j+1)]);xlabel('Time (day)'); ylabel('WWPT (stb)');
   hold off
    
end
% 
% for k=1:NbClusters
%    en_num_vec=find(Clustering.T==k);
%    Well_by_en=Well(en_num_vec); 
%    for j=1:NbProd
%        
%        
%    end
%     
% end
% 
% 
% 
% 
% 
% for k=1:NbProd
%     fig_h(k)=figure(k+figstart);
%     
% end
% 
% for k=1:NbSimul
%     C_h=C(Clustering.T(k),:);
%     Well_h=Well(:,k);
%     for j=1:NbProd
%         data_h=cell2mat(Well_h);
%         dynamic=data_h(:,ParamNum);
%         time=data_h(:,2);
%         plot(fig_h(j),time,dynamic,'Color',C_h);
%         hold on
%     end
% end
% 
% hold off
% end