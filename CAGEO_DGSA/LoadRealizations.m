function parameters=LoadRealizations(xlsname,Row_w_variables)
%% This function reads an excel file that cotains values of each realization generated from Monte Carlo Simulations
%%% and assign the values and names of variables to output variable\

%%% Input
%%% xlsname : The name of an excel file to read. Exclud the extension
%%% Row_data_starts : The number of rows that has names of variables. For
%%% exported file generated from StudioSL, it is 3. 

%%% Output
%%% parameters.num_models : The number of realizations
%%% parameters.num_variables : The number of varaibles
%%% parameters.names_variables : cell of length of parameters.num_variables, Names of each variable
%%% parameters.dataset : parameters.num_models X parameters.num_variables, Values of each parameter for every realization

%%
xlsname=[xlsname,'.xlsx'];
[data_from_xls, txtfield]=xlsread(xlsname);
parameters.values=data_from_xls;
[parameters.num_models, parameters.num_variables]=size(data_from_xls); 
parameters.names_variables=txtfield(Row_w_variables,2:end);

end
