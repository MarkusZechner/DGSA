function InteractionsNames=create_interactions_name(ParametersNames)
%% Interaction Names
InteractionsNames=cell(1,(length(ParametersNames)^2-length(ParametersNames)));
ncount=0;
for k=1:length(ParametersNames)

    behind_name=ParametersNames{k}; 
    
    
        
    for j=1:length(ParametersNames)
       
        if k==j
            
            continue
            
        end
        front_name=ParametersNames{j};
        name_handle=[front_name,'|',behind_name];
        ncount=ncount+1;
        InteractionsNames{ncount}=name_handle;
        
    end

    


end

end