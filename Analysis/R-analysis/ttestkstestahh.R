setwd("/Users/william/Dropbox (Amherst College)/CDS-2019-AlbanyHub/analysis")
MyData = read.csv("realprojind.csv")

proj = MyData[MyData$ProjInd == 1,]
nonproj = MyData[MyData$ProjInd == 0,]

MyData[MyData$Size == 0,]

summary(proj)

proj$Size
nonproj$Size
t.test(proj$Size, nonproj$Size, var.equal=FALSE)
t.test(proj$Baths, nonproj$Baths, var.equal=FALSE)
t.test(proj$Beds, nonproj$Beds, var.equal=FALSE)
t.test(proj$Rooms, nonproj$Rooms, var.equal=FALSE)
t.test(proj$Assessment, nonproj$Assessment, var.equal=FALSE)
t.test(proj$Market, nonproj$Market, var.equal=FALSE)
t.test(proj$LotSize, nonproj$LotSize, var.equal=FALSE)
t.test(proj$Consumption, nonproj$Consumption, var.equal=FALSE)

t.test(as.numeric(proj$FoundationType), as.numeric(nonproj$FoundationType, var.equal=FALSE))
summary(as.numeric(proj$))
sum(is.na(proj$FoundationType))
summary(proj)

summary(as.numeric(proj$ZoningType))
summary(as.numeric(proj$PropClass))
summary(as.numeric(proj$Floors))
summary(as.numeric(proj$Condition))
summary(as.numeric(proj$RoofCover))
summary(as.numeric(proj$WallType))

summary(nonproj)

summary(as.numeric(nonproj$FoundationType))
summary(as.numeric(nonproj$ZoningType))
summary(as.numeric(nonproj$PropClass))
summary(as.numeric(nonproj$Floors))
summary(as.numeric(nonproj$Condition))
summary(as.numeric(nonproj$RoofCover))
summary(as.numeric(nonproj$WallType))

tbl_foundation = table(MyData$FoundationType, MyData$ProjInd)
chisq.test(tbl_foundation)

tbl_zoning = table(MyData$ZoningType, MyData$ProjInd)
chisq.test(tbl_zoning)

tbl_propclass = table(MyData$PropClass, MyData$ProjInd)
chisq.test(tbl_propclass)

tbl_floors = table(MyData$Floors, MyData$ProjInd)
chisq.test(tbl_floors)

tbl_condition = table(MyData$Condition, MyData$ProjInd)
chisq.test(tbl_condition)

tbl_foundation = table(MyData$FoundationType, MyData$ProjInd)
chisq.test(tbl_foundation)

tbl_roofcover = table(MyData$RoofCover, MyData$ProjInd)
chisq.test(tbl_roofcover)

tbl_walltype = table(MyData$WallType, MyData$ProjInd)
chisq.test(tbl_walltype)
tbl_foundation[,'0']

ks.test(tbl_foundation[,'0'], tbl_foundation[,'1'])
