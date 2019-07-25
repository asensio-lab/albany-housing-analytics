
library(readr)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(forcats)
library(xtable)
library(stringr)
library(zoo)
library(data.table)
library(lubridate)
library(plotly)
setwd("/home/mirabel/Dropbox (GaTech)/CDS-2019-AlbanyHub/analysis")
df = read_csv("homerehab.csv")
df_w = read_csv("weather.csv")
df_g <- df %>% filter(ServiceType == "RGAS") %>% group_by(address, ServiceType, Year, Month) 
df_e <- df %>% filter(ServiceType == "RELC") %>% group_by(address, ServiceType, Year, Month) 
head(df)
nrow(df)

# Group by variables to keep, summarize consumption and consumption per SQFT so that there is only one record for a property per month
df_g1 <- df_g %>% group_by(address, ServiceType, Year, Month, DaysOfService, AddressID, ChargeDate) %>% summarise(TotalConsumption =sum(Consumption), TotalConsPerSQFT = sum(ConsumptionPerSQFT))
nrow(df_g1)
head(df_g1)
# Change the month of the ChargeDate to accurately represent that the utility consumption comes from

for (proj in 1:nrow(df_g1)) {
  month(df_g1$ChargeDate[proj]) = month(df_g1$ChargeDate[proj]) - 1
  if (df_g1$Month[proj] == 1) {
    df_g1$Month[proj] = 12
    df_g1$Year[proj] = df_g1$Year[proj] - 1 
  } else {
    df_g1$Month[proj] = df_g1$Month[proj] - 1 
  }
}

# Normalize consumption per sq ft by the days of the month the bill comes from
nod <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
nod_ly <- c(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)

for (proj in 1:nrow(df_g1)) {
  m = df_g1$Month[proj]
  if (df_g1$Year[proj] %% 4 == 0) {
    d = nod_ly[m]
    df_g1$NormalConsSQFT = df_g1$TotalConsPerSQFT / d
  } else {
    d = nod[m]
    df_g1$NormalConsSQFT = df_g1$TotalConsPerSQFT / d
  }
}
nrow(df_g1)

# Check for any addresses where there is zero consumption for the whole year
y <- df_g1 %>% group_by(address, Year) %>% summarise(TotalNormal = sum(NormalConsSQFT))
for (proj in 1:nrow(y)) {
  if (y$TotalNormal[proj] == 0) {
    df_g1 <- subset(df_g1, !(df_g1$address == y$address[proj] & df_g1$Year == y$Year[proj]))
  }
}
nrow(df_g1)

# Find mean consumption for all records in dataset per month
m <- df_g1 %>% group_by(Month, Year) %>% summarise(MeanNormalCons = mean(NormalConsSQFT))
m$ym <- as.yearmon(paste(m$Year, m$Month), "%Y %m")
g_mean_h<-m
p1 <- ggplot(m, aes(x=ym, y=MeanNormalCons)) + geom_line() +
  labs(x = '', y = 'Mean CCF/sq ft/day') + 
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())+
  ggtitle('Mean Consumption (gas and electricity) of Homeowner Rehab Projects')
  
p1

# Group by variables to keep, summarize consumption and consumption per SQFT so that there is only one record for a property per month
df_e1 <- df_e %>% group_by(address, ServiceType, Year, Month, DaysOfService, AddressID, ChargeDate) %>% summarise(TotalConsumption =sum(Consumption), TotalConsPerSQFT = sum(ConsumptionPerSQFT))
nrow(df_e1)

# Change the month of the ChargeDate to accurately represent that the utility consumption comes from

for (proj in 1:nrow(df_e1)) {
  month(df_e1$ChargeDate[proj]) = month(df_e1$ChargeDate[proj]) - 1
  if (df_e1$Month[proj] == 1) {
    df_e1$Month[proj] = 12
    df_e1$Year[proj] = df_e1$Year[proj] - 1 
  } else {
    df_e1$Month[proj] = df_e1$Month[proj] - 1 
  }
}

# Normalize consumption per sq ft by the days of the month the bill comes from
nod <- c(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
nod_ly <- c(31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)

for (proj in 1:nrow(df_e1)) {
  m = df_e1$Month[proj]
  if (df_e1$Year[proj] %% 4 == 0) {
    d = nod_ly[m]
    df_e1$NormalConsSQFT = df_e1$TotalConsPerSQFT / d
  } else {
    d = nod[m]
    df_e1$NormalConsSQFT = df_e1$TotalConsPerSQFT / d
  }
}

# Check for any addresses where there is zero consumption for the whole year
y1 <- df_e1 %>% group_by(address, Year) %>% summarise(TotalNormal = sum(NormalConsSQFT))
for (proj in 1:nrow(y1)) {
  if (y1$TotalNormal[proj] == 0) {
    df_e1 <- subset(df_e1, !(df_e1$address == y1$address[proj] & df_e1$Year == y1$Year[proj]))
  }
}
nrow(df_e1)

# Find mean consumption for all records in dataset per month
m1 <- df_e1 %>% group_by(Month, Year) %>% summarise(MeanNormalCons = mean(NormalConsSQFT))

m1$ym <- as.yearmon(paste(m1$Year, m1$Month), "%Y %m")
e_mean_h<-m1
p2 <- ggplot(m1, aes(x=ym, y=MeanNormalCons)) + geom_line() + 
  labs(x = '', y = 'Mean kWh/sq ft/day') + 
  expand_limits(y = 0) + 
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
p2

df_w$date <- ymd(paste(df_w$Year,df_w$Month,'28', sep="-"))
df_w <- subset(df_w, df_w$date > '2011-11-28' & df_w$date < '2019-01-28')
p3 <- ggplot(df_w, aes(x=date, y=MeanTemp)) + geom_line() + 
  labs(x = 'Time', y = 'Average Temperature (°F)')
p3

grid.arrange(p1, p2, p3,  nrow = 3) 

p <-subplot(p1,p2,p3, nrows = 3, titleY = TRUE, titleX = TRUE) %>% layout(title = "Mean Consumption (gas and electricity) of Homeowner Rehab Projects")
grid.arrange(p1, p0, p2,  nrow = 3) 
p 
orca(p, 'output.png')
```