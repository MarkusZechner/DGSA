function MatrixSum=MakeSumConditional(SensitivityInteractions,DisplayPlotFlag)
%% Written 1 Feb 2015

%% Input :
%SensitivityInteractions : From the main part, [SensitivityInteractions,GlobalSensitivityInteractions] = dGSA_Interactions(Clustering,ParametersValues,InteractionsNames,NbBins);
%ConditionalParameterNum : x : 1, y: 2, z: 3 For the test, put y=2, as
%Addy's paper.
%DisplayPlot=1 : Show plot, DisplayPlot=0, just get the value

%% Output
%%% If DisplayPlotFlag=1, it gives the plot.
%%% p_condi2Matrix gives the matrix that used to make the plot
%%% MaxSensBin is the number of bin that has the maxium sensitivity

[NbParms, ~, NbClusters, NbMaxBins]=size(SensitivityInteractions);
SensitivityInteractionOverClass=nanmean(SensitivityInteractions, 3); % Average over cluster

SensitivityInteractionSumInter=sum(SensitivityInteractionOverClass,2);
MatrixSum=zeros(NbParms, NbMaxBins);

%p_conditional=SensitivityInteractionOverClass(ConditionalParameterNum,:,:,:); 
% p is that p from s(p_i | p_j)
% Next thing to do, is to make the below output as a simple matrix
%[~, NumParamMinus1, ~, NbBinsP_Conditional]=size(p_conditional);

%p_condi2Matrix=zeros(NbBinsP_Conditional,NumParamMinus1); % InitializeTheMatrix

for k=1:NbMaxBins
    
    MatrixSum(:,k)=SensitivityInteractionSumInter(:,:,:,k);    % The reason why doing this is that in the stacked bar graph, stacked
    % value should be written in row vector of each matrix. For example
    % Item1 : 1 2 4 comprises one bar.
    
    
end
% 
% if DisplayPlotFlag
%     
%     figure;
%     bar(p_condi2Matrix,'stacked');
%     set(gca,'XTickLabel', {'0.001','.01','0.1'});
% end
% 
%         
% [~,MaxSensBin]=max(sum(p_condi2Matrix,2));
% 



%{
yConditional(:,:,1,1) =

    1.0754    0.7734


yConditional(:,:,1,2) =

    0.3850    0.6939


yConditional(:,:,1,3) =

    1.4247    0.5148

%}

end
