function [ DM ] = ComputeWeightedEuclideanDistance( Data, Time )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

rows = size(Data, 1)
columns = size(Data, 1)

DM = zeros(rows, columns);

deltaTime = diff(Time);
deltaTime = [0 deltaTime];

for row=1:rows
    
    for column = row:rows
        
        PropertyVector1 = Data(row,:);
        PropertyVector2 = Data(column,:);
        
        Difference = PropertyVector1 - PropertyVector2;
        
        SquaredDifference = Difference .^2;
        
        SquareDiffXdeltaTime = SquaredDifference .* deltaTime;
        
        DM(row,column) = sqrt(sum(SquareDiffXdeltaTime) / sum(deltaTime));
        
        
        
    end
    
end

DM = DM + transpose(DM);

end

