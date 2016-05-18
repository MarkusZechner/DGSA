function C=DisplayMDSplot(d, Clustering)
% The function displays MDS plot from distance matrix and clustering results
% Author: Jihoon Park (jhpark3@stanford.edu)
% Date: 16 May 2016

% Input:
% d: Distance vector or matrix
% Clustering: Clustering results from DGSA

% Output:
% C (optional): Color code of each cluster

% Multi-Dimensional Scaling (MDS) using distance d
[Xd_, e_] = cmdscale(d);

% Reduction of the dimension of the MDS space, here 2D
dims = 2;
Xd = Xd_(:,1:dims);
Clustering.label=Clustering.T;

C=plotcmdmap(Xd, Clustering);
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
set(gca, 'XTickLabelMode', 'manual', 'YTickLabel', []);

xlabTxt=['Varaince explained:',num2str(round(e_(1)/sum(e_)*100)),'%'];
ylabTxt=['Varaince explained:',num2str(round(sum(e_(2))/sum(e_)*100)),'%'];    

xlabel(xlabTxt,'Fontsize',14); ylabel(ylabTxt,'Fontsize',14);

end