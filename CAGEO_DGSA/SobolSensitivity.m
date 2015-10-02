function S=SobolSensitivity(tgrid,responses,N_unit_simul,ParametersNames)
%% Input
NbTotalSimul=size(responses,1);
%tgrid=0:365:7300;tgrid=tgrid'; % Just for convinence, keep this
%t_seq=2; r_seq=12;NbTotalSimul=14000; %r_seq=14 for FWPT for FWPT
N_unitsimul=1000;
NbParam=length(ParametersNames);% Now this is not 15 because geometric parameters are gone.

%% Extract dynamic data
%C=zeros(length(tgrid), NbSimuPer, NbParam+2); 
responses=[zeros(NbTotalSimul,1),responses];
C=responses';

% % for k=1:NbTotalSimul
% %     t_h=Field14000{k}(:,t_seq);
% %     r_h=Field14000{k}(:,r_seq); % r means response
% %     r_h_interp=interp1(t_h,r_h,tgrid); % Interpolation
% %     C(:,k)=r_h_interp;
% %     
% end

C_reshaped=reshape(C, length(tgrid), N_unit_simul, NbParam+2);

A=C_reshaped(:,:,1); B=C_reshaped(:,:,2); % Assign the first and the second one to A, B

for k=1:length(tgrid)
    sigma_y_i=var(A(k,:)); % sigma_y_i
    for i=1:NbParam
        C_i=C_reshaped(k,:,i+2); % This is the vector, this should be row vector.
        A_i=C_reshaped(k,:,1);
        B_i=C_reshaped(k,:,2);
        S(i,k)=1-norm(C_i-A_i)^2/sigma_y_i/(2*(N_unitsimul-1));
        S_t(i,k)=norm(C_i-B_i)^2/sigma_y_i/(2*(N_unitsimul-1));    
        
    end
    
    
end

%% Plotting - Single way sensitivity
S(:,1)=zeros(length(S(i,1)),1); % just make it 0
LineSeries={'b','r','k','m','--b','--r','--k','--m',':b',':r',':k',':m'};

figure
for k=1:NbParam
    plot(tgrid, S(k,:),LineSeries{k},'LineWidth',3); hold on
    
end
%ParametersNames={'oilvis','dtmax','kvkh','mflt1','mflt2','mflt3','mflt4',...
%    'oilexp','owc','sorw','swc','watexp','scen','prop','size'};
legend(ParametersNames,'Location','EastOutside');
xlim([0 tgrid(end)]);ylim([0 1]);xlabel('Time (day)','Fontsize',12);
ylabel('Sensitivity','Fontsize',12);
set(gca,'Fontsize',12);
hold off

%S(i,1)=zeros(length(S(i,1),1));


















% %% Parameters addressed.
% tstep=30; tgrid=tstep:tstep:900;tgrid=tgrid';
% 
% %% Plot FOPT
% A=r_all(1,:); % Take the array.
% for k=1:NbSimu
%     time_h=A{k}(:,1); FOPT=A{k}(:,7);
%     FOPT_int_k=interp1(time_h,FOPT,tgrid);
%     
%     FOPT_int_k=[FOPT_int_k(1);FOPT_int_k];
%     plot([0;tgrid], FOPT_int_k*10^3); hold on
%     
% end
% 
% hold off
% %%  Interpolate
% interpolated=zeros(length(tgrid), NbSimu, NbParams+2);
% for k=1:5
%     C_k=r_all(k,:); % Pick this up
%     for i=1:100
%         C_i=C_k{i};
%         t_h=C_i(:,1); res_h=C_i(:,7);
%         interpolated(:,i,k)=interp1(t_h,res_h,tgrid);
%         
%     end
% 
% end
% 
% %% Sobol Index Again
% A=interpolated(:,:,1);
% B=interpolated(:,:,2);
% %%
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %% Sobol Index....
% %A_r=r_all(1,:); % Take the first low. 
% FOPT_sq=7;
% for k=1:length(tgrid)
%     
%     for i=3:NbParams+2
%         C_i=r_all(i,:); 
%         A_i=r_all(1,:); % Pick up A in this place.
%         clear A_h_v; clear C_h_v;
%         for m=1:NbSimu
%             
%             A_m=A_i{m};
%             C_m=C_i{m};
%             
%             A_time_h=A_m(:,1);
%             C_time_h=C_m(:,1);
%             
%             A_h_v(m)=interp1(A_time_h, A_m(:,FOPT_sq), tgrid(k));
%             C_h_v(m)=interp1(C_time_h, C_m(:,FOPT_sq), tgrid(k));
%             
%             
%    
%         end
% %         mu_y=mean(A_h_v);
% %         sigma_y_sq=var(A_h_v);
% %         partialsum=(A_h_v-mu_y)*(C_h_v-mu_y)';
% %         S(i-2,k)=partialsum/sigma_y_sq/(NbSimu-1);
%         S(i-2,k)=1-(norm(A_h_v-C_h_v))^2/(var(A_h_v)*2*(NbSimu-1));
%         %(i-2,k)=1-(norm(A_h_v-C_h_v))^2/(var(A_h_v)*2*(NbSimu-1));
%     end
% end
% 
% Color={'b','k','r'}; figure; hold on
% for k=1:3
%     plot(tgrid, S(k,:), Color{k}, 'LineWidth', 2);
% end
% legend(ParametersNames{1},ParametersNames{2},ParametersNames{3});
% hold off 
