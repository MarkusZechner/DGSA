function X=GetAsymmetricDistanceHplot_diagnal0(A,NbPara)
%% 2015.03.01
%%% Author : Jihoon Park
%%% This scripts returns X=[D'|D] where D is asymmetric distance amtrix 

%% Input
%%% A: Vector which has Standardized interaction sensitivities
%%% NbPara : Number of Parameters. In Wintershall case, it is 15.
%%% Notice that compared to GetAsymmetricDistanceHplot.m,
%%% StandardizedSensitivty and minSens are removed since all diagonal terms
%%% should be 0

%% Take the inverse first.
A=1./A; 

%% Make the asymmetric distance matrix
NbInterPer=NbPara-1; % Now I am trying to build the distance matrix 'large' delta. Since the inverse of interation sensitivities should be used 
                     % as distance, 'large' data should be NbPara * NbPara
               
                     
                     
A_reshaped=reshape(A,NbInterPer,[]);
A_augmented=zeros(NbPara);

for k=1:NbPara
   
    A_augmented(:,k)=InsertNumVec(A_reshaped(:,k),k,0);
    
end

D=A_augmented;
X=[D, D'];
%X=[D',D];
%% Fill out the single way sensitivity
% for k=1:NbPara
%    A_augmented(k,k)=Normal_GlobalSens(k);    
% end
% 
% %% 
% D=A_augmented; % Change this to follow the notation in the paper.  The row is conditional (given) 
% X=[D',D]; % This is X=[D'|D];








%% 

% 
% D=zeros(NbPara);
% for i=1:NbPara-1
%     
%     for j=i+1:NbPara
%         if Type
%         D(i,j)=1/((A_augmented(i,j)+A_augmented(j,i))*.5);
%         else
%             D(i,j)=std([A_augmented(i,j),A_augmented(j,i)],1)*50;
%       
%         end
%     end
% end
% 
% D=D+D';