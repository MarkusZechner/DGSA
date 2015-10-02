function Responses=GetdynamicResponses(Well, tgrid,seq)
% Well : self explanatory
% tgrid : reference tgrid. tgrid should be row vector.
n_prod=size(Well,1);
n_model=size(Well,2);
n_tstep=length(tgrid);
%% Initialize the output
Responses=zeros(n_model,n_tstep,n_prod);


%% Fill the output matrix
for j=1:n_prod
    data_prod_j=Well(j,:);
    for k=1:n_model
        data_en_k=data_prod_j{k}; % Acess to matrix
        dynamic_h=data_en_k(:,seq); % Take out dynamic data
        time_h=data_en_k(:,1); % Take out time
        dynamic_h=dynamic_h'; 
        time_h=time_h';
        dynamic_time_adjusted=interp1(time_h,dynamic_h,tgrid);
        Responses(k,:,j)=dynamic_time_adjusted;
    end
end



end