function D=GetDistMatrixfromInterSens(A,NbPara)
%close all; clear all;
%A=[.1,.2,.3,.15,.2,.3]'; % Test 3
%NbPara=3;
NbInterPer=NbPara-1;
A_reshaped=reshape(A,NbInterPer,[]);
A_augmented=zeros(NbPara);

for k=1:NbPara
   
    A_augmented(:,k)=InsertNumVec(A_reshaped(:,k),k,-999);
    
end

D=zeros(NbPara);
for i=1:NbPara-1
    
    for j=i+1:NbPara
        
        D(i,j)=1/((A_augmented(i,j)+A_augmented(j,i))*.5);
       
    end
end

D=D+D';