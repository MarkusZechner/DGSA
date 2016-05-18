function CompareResponses(Prior,AfterPUR,DataStruct)
% The function compares two responses - 1) Prior responses, 
%   2) Responses from parameters whose uncertainies are reduced by DGSA
% Author: Jihoon Park (jhpark3@stanford.edu)
% Date: 17 May 2016

% Input:
% Prior: cell (# of wells x # of models), each cell has matrix of time(1st column) and response(2nd column)
%        Responses are from prior distributions of parameters. 
% AfterPUR: cell (# of wells x # of models), each cell has matrix of time(1st column) and response(2nd column)
%        Responses are from distributions of parameters that are reduced by DGSA and net conditional effects 
% DataStruc: Inputs needed for display. See the next part
%
% Output: subplot to show responses
%% Assign varaibles
tgrid=DataStruct.tgrid; % Time steps
idx=DataStruct.idxResponse; % The column that contains response
QuantileLevel=DataStruct.QuantileLevel; % Quantiles to plot
xlabtxt=DataStruct.xlab; % xlegend
ylabtxt=DataStruct.ylab; % ylegend

%%
ResponsesPrior=GetdynamicResponses(Prior,tgrid,idx);
ResponsesPUR=GetdynamicResponses(AfterPUR, tgrid, idx); 

NbProdWell=size(Prior,1);
figure;
for k=1:NbProdWell
    subplot(1,NbProdWell,k);
    Quantiles_k=QuantileComputation(ResponsesPrior(:,:,k),QuantileLevel);
    Quantiles_k_PUR=QuantileComputation(ResponsesPUR(:,:,k),QuantileLevel);

    ResponsesPrior_k=ResponsesPrior(:,:,k);
   
    hold on
    for k2=1:size(ResponsesPrior_k,1)
        plot([0,tgrid], [0,ResponsesPrior_k(k2,:)],'Color',[.7,.7,.7]);    
    
    end
    
    add0=[0;0;0];
    h1=plot([0,tgrid], [add0,Quantiles_k],'-.k','LineWidth',4);
    
    h2=plot([0,tgrid], [add0,Quantiles_k_PUR],'-r','LineWidth',3);
       
    xlim([0 tgrid(end)]);ylim([0 7E7]);
    
    xlabel(xlabtxt);ylabel(ylabtxt);
    title(['Prod ',num2str(k+1)])
    
    legend([h1(1),h2(1)],'Initial Models','Reduced', ...
        'location','NorthWest');
    hold off

end


end