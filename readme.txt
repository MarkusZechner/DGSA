Distance-based Generalized Sensitivity Analysis (dGSA)

Clustering (kmedoid) should be performed on the responses to classify the models in a few (2-3) classes prior to the sensitivity analysis.
The clustering results should be provided as an input (in the same format as the output of kmedoids.m)

The Matlab function to apply dGSA on the main factors is dGSA_MainFactors.m.  
The Matlab function to apply dGSA on the interations is dGSA_Interactions.m.  

An example of application is given in demo_dGSA_analytic.m

Reference: Fenwick D, Scheidt C. and Caers J. (2014) Quantifying Asymmetric Parameter Interactions in Sensitivity Analysis: Application to Reservoir Modeling. Mathematical Geosciences 46(4): 493-511

 