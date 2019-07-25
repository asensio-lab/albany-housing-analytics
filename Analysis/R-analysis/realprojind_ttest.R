library(tidyverse)

proj <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/analysis/realprojind.csv")
attach(proj)
ProjInd <- as.factor(ProjInd)


t.test(LotSize ~ ProjInd)
t.test(Size ~ ProjInd)
t.test(Baths ~ ProjInd)
t.test(Beds ~ ProjInd)
t.test(Rooms ~ ProjInd)
t.test(Assessment ~ ProjInd)
t.test(Market ~ ProjInd)
