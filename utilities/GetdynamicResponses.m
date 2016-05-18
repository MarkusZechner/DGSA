function Responses=GetdynamicResponses(Responses_cell, tgrid,seq)
% The function converts cell to matrix with linear inerpolation of time steps
% Interpolation is carried out since different time steps can be used
%
% Author: Jihoon Park (jhpark3@stanford.edu)
%
% Input:
% Responses_cell : cell (# of wells x # of models), cell that contains response
% tgrid : reference tgrid. tgrid should be row vector.
%
% Output: 
%
% Responses: matrix (# of wells x # of timesteps), contains response which is interpolated over reference 'tgrid'
%
n_prod=size(Responses_cell,1);
n_model=size(Responses_cell,2);
n_tstep=length(tgrid);
%% Initialize the output
Responses=zeros(n_model,n_tstep,n_prod);


%% Fill the output matrix
for j=1:n_prod
    data_prod_j=Responses_cell(j,:);
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