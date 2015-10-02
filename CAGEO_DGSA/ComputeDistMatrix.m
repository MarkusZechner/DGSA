function D=ComputeDistMatrix(AllResponses,timeinterval,dt)

%% 
%%% Allresponses : cell(1,NumofModels), which has all responses with time
%%% timeinterval : Reference time interval to unify the time interval of responses

Nwells=size(AllResponses,1); % The number of observed wells
NRealizations=size(AllResponses,2); % The number of ensembles
Ntsteps=length(timeinterval);
ResponsesCombined=zeros(NRealizations,Ntsteps*Nwells);

for j=1:NRealizations
    
   %%% Use Reshape!
   response_j=zeros(Nwells,Ntsteps);
    for i=1:Nwells
        
        response_j(i,:)=interp1(AllResponses{i,j}(:,1),AllResponses{i,j}(:,2),timeinterval')'; 
        

    end
    
    ResponsesCombined(j,:)=reshape(response_j',1,[]); 
    
end

%% Compute Distance Matrix
D=pdist(ResponsesCombined);
D=D*sqrt(dt/timeinterval(end)/Nwells);


end







