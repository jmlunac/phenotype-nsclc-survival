# phenotype-nsclc-survival
Companion code for paper submission

11/12/2021
Jose Marcio Luna, PhD
Center for Biomedical Image Computing and Analytics
Department of Radiology, University of Pennsylvania

Companion code for Cancers Submission:
Title: Radiomic Phenotypes for Improving Early Prediction of Survival in Stage III Non-small Cell Lung Cancer Adenocarcinoma 
After Chemoradiation
Authors: José Marcio Luna, Andrew R. Barsky, Russell T. Shinohara, Leonid Roshkovan, Michelle Hershman, Alexandra D. Dreyfuss,
Hannah Horng, Carolyn Lou, Peter B. Noël, Keith A. Cengel, Sharyn Katz, Eric S. Diffenderfer and Despina Kontos
  
The feature harmonization step is performed before running this sample code. Therefore the file Features.csv is assumed to have been harmonized already.
For this specific study we used the generalized-combat function available at https://github.com/hannah-horng/generalized-combat developed at our center.

This sample code uploads patient information consisting on three types: a) a file named Covariates.csv containing clinical covariates for every patient
such as age at diagnosis, ECOG, BMI or pack-year, b) a file named Features.csv containing radiomic features extracted from images associated to each patient,
e.g., PET or CT images; and c) a file named Outcomes.csv containing the outcomes suitable for survival analysis with their respective time-to-event, e.g., 
event of death, and date of death or censor dates.

The code calculates the first principal components explaining 80% of the variance of the radiomic features. Then it calculates a binary imaging phenotype 
(e.g., high v. low risk of death), and then fits a Cox model to predict the event of death. The algorithm shows the predictive performance of a model 
based only on the imaging phenotype, and compares against another model that integrates the imaging phenotype with other covariates (e.g., age at diagnosis 
and ECOG) by providing the C-statistics of both models.

The attached csv files contain simmulated data to test the functionality of the codes since the data presented in this study are available on request 
from the corresponding author.