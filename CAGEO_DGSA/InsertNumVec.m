function y=InsertNumVec(a1,i,Num)
%a1=[1;2;3;4;5;6]; i=7;
n=size(a1,1);
y=Num*ones(n+1,1);


for k=1:n
    
   if k==i
       break;
   else
       y(k)=a1(k);
   end
    
end

for j=k+1:n+1
   
    y(j)=a1(j-1);
    
end

if i==n+1
    y(end)=Num;
end

%y'
% 
% while count<=n
%     
%     
%     
% end

