setwd("/Users/william/Dropbox (Amherst College)/CDS-2019-AlbanyHub/analysis")

MyData = read.csv("util_real_2012_3.csv")

library(MatchIt)
library(Matching)
library(rgenoud)
MyData <- na.omit(MyData)
attach(MyData)
X = cbind(PropClass, Size, ZoningType, Floors, Condition, FoundationType, RoofCover, WallType)
Tr = ProjInd

genout <- GenMatch(Tr, X=X, pop.size = 300, max.generations = 10, wait.generations = 2,
                   hard.generation.limit = TRUE, MemoryMatrix=FALSE, fit.func = "pvals",
                   ties=TRUE, replace=TRUE, CommonSupport =FALSE, nboots = 0, ks=TRUE,
                   verbose=TRUE, paired=TRUE)
