function C=DisplayMDSplot(d, Clustering)

% Multi-Dimensional Scaling (MDS) using distance d
[Xd_, e_] = cmdscale(d);

% Reduction of the dimension of the MDS space, here 3D
dims = 2;
Xd = Xd_(:,1:dims);
Clustering.label=Clustering.T;
C=plotcmdmap(Xd, Clustering);
set(gca, 'XTickLabelMode', 'manual', 'XTickLabel', []);
set(gca, 'XTickLabelMode', 'manual', 'YTickLabel', []);
end