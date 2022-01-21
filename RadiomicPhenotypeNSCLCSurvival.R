# 11/12/2021
# Jose Marcio Luna, PhD
# Center for Biomedical Image Computing and Analytics
# Department of Radiology, University of Pennsylvania

# Companion code for Cancers Submission:
# Title: Radiomic Phenotypes for Improving Early Prediction of Survival in Stage III Non-small Cell Lung Cancer Adenocarcinoma After Chemoradiation
# Authors: José Marcio Luna, Andrew R. Barsky, Russell T. Shinohara, Leonid Roshkovan, Michelle Hershman, Alexandra D. Dreyfuss,
# Hannah Horng, Carolyn Lou, Peter B. Noël, Keith A. Cengel, Sharyn Katz, Eric S. Diffenderfer and Despina Kontos
  
library(survival)

# Importing the data
datadirectory = "data/" # Edit the path where Covariates, Features and Outcomes are stored as indicated in the attached csv samples
covariates = read.csv(file.path(datadirectory, "Covariates.csv")) # This file contains the values of the clinical covariates
features = read.csv(file.path(datadirectory, "Features.csv")) # This file contains the radiomic features extracted from each study
outcomes = read.csv(file.path(datadirectory, "Outcomes.csv")) # This files contains the events of interest, e.g., death, progression and time-to-events.
head(covariates)
head(features)
head(outcomes)

# Calculating principal components
pcs <- prcomp(features, center = T, scale. = T, rank. = 8)
dim(pcs$x)
# Selecting principal components explaining 80% of the variance of the radiomic features
minpc = min(which(summary(pcs)[[6]][3,] > 0.8))
mainpcs <- pcs$x[,1:minpc]
dim(mainpcs)
head(mainpcs)

# Calculating imaging phenotype using hierachical clustering with two clusters
normpca <- scale(mainpcs)
hclus<-hclust(as.dist(dist(normpca)),method="ward.D2")
plot(as.dendrogram(hclus))
phenotype <- cutree(hclus,2)
table(phenotype)

dim(mainpcs)
dim(features)

# Fitting Cox models for comparison
# Fitting model with phenotype only
phenotypemodel <- coxph(Surv(outcomes$TIME, outcomes$DEAD) ~ phenotype)
# Fitting model integrating phenotype with Age and ECOG
integratedmodel <- coxph(Surv(outcomes$TIME, outcomes$DEAD) ~ phenotype + covariates$AGE_AT_DIAGNOSIS + covariates$ECOG)
# Calculating predictive performance of both models
summary(phenotypemodel)
summary(integratedmodel)