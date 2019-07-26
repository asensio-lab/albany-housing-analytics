library(ggplot2)
library(readr)
library(plotly)
library(gtable)
library(grid)
library(gridExtra)
#This file supports Investigate_Distribution.ipynb
#Read the mean gas and electric consumptions and plots them against weather
#Also compares gas and electric consumptions to weather with regression
#In various configurations
setwd("/home/mirabel/Dropbox (GaTech)/CDS-2019-AlbanyHub/analysis/create_plots_residential_HOME")
e_mean <- read_csv("elec_residential.csv")
g_mean <- read_csv("gas_residential.csv")
he_mean<- read_csv("elec_home.csv")
hg_mean<- read_csv("gas_home.csv")



weather<- read_csv('/home/mirabel/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/LCD_month.csv')
weather<-weather[132:217, ] #Crop out irrelevant dates

#P0: electric means
p0<-ggplot(data = e_mean, mapping = aes(x = DATE, y = Consumption_norm)) + 
  geom_line()+
  labs(title ='',
        y='Mean kWh/Sq Ft/Day',
        x = '')+ 
  theme(axis.text.x = element_blank(),axis.ticks.x=element_blank())+
  expand_limits(y=0)
#P1: Gas means
p1<-ggplot(data = g_mean, mapping = aes(x = DATE, y = Consumption_norm)) + 
  geom_line()+
  labs(y='Mean CCF/Sq Ft/Day',
       x='')+ 
  theme(axis.text.x = element_blank(),axis.ticks.x=element_blank())+ 
  ggtitle("Mean Consumption (gas and electricity) of Residential Properties")
#P2: weather
p2<-ggplot(data=weather, mapping = aes(x=DATE, y=MonthlyMeanTemperature))+
  geom_line()+labs(y='Average Temperature (°F)', x='Time')

#Plot all 3 in different ways
grid.arrange(p1, p0, p2,  nrow = 3) 
#sp<-subplot(p1, p0, p2, nrows=3, titleY=TRUE, titleX=TRUE) %>% layout(title = "Mean Consumption (gas and electricity) of Residential Properties")
#subplot(p0, p2, nrows=2, titleY=TRUE, titleX=TRUE)

#######################################################
#get e_mean_h and g_mean_h by running Olivia's R file (test.R)
#Plots homeowner rehabilitation projects vs all residential
e_mean_h<-e_mean_h[order(e_mean_h$ym),] # Order by month and year
g_mean_h<-g_mean_h[order(g_mean_h$ym),]
e_mean$Con2 = e_mean_h$MeanNormalCons # Combine into one dataframe
e_mean$ym = e_mean_h$ym 
g_mean$Con2 = g_mean_h$MeanNormalCons # Combine into one dataframe
g_mean$ym = g_mean_h$ym 
e_mean_1 = e_mean[48:58,] #Subplot for 1 year -> comment out to get full
g_mean_1 = g_mean[48:58,]
weather1 = weather[26:37,]
#Q1: Electric, residential vs homeowner rehab
q1<-ggplot(data=e_mean_1)+
  geom_line(mapping=aes(x=DATE, y=Consumption_norm, color='Residential'))+
  geom_line(mapping=aes(x=DATE, y=Con2, color='Homeowner Rehabilitation'))+ 
  expand_limits(y=0)+ 
  theme(legend.title=element_blank(), legend.position = c(0.05,0.15), axis.text.x = element_blank(), axis.ticks.x=element_blank())+
  labs(title ='',
       y='Mean kWh/Sq Ft/Day',
       x = '')
#Q2: Gas, residential vs homeowner rehab
q2<-ggplot(data=g_mean_1)+
  geom_line(mapping=aes(x=DATE, y=Consumption_norm, color='Residential'))+
  geom_line(mapping=aes(x=DATE, y=Con2, color='Homeowner Rehabilitation'))+ 
  expand_limits(y=0)+ 
  theme(legend.title=element_blank(), legend.position = c(0.05,0.15), axis.text.x = element_blank(), axis.ticks.x=element_blank())+
  labs(title ='Gas and Electricity Consumption: Homeowner Rehabilitation vs All Residential',
       y='Mean CCF/Sq Ft/Day',
       x = '')
#Q3: Weather
q3<-ggplot(data=weather1, mapping = aes(x=DATE, y=MonthlyMeanTemperature))+
  geom_line()+labs(y='Average Temperature (°F)', x='Time')
  #theme(axis.ticks.x=c('Jan 2014', 'Feb 2014', 'Mar 2014', 'Jan 2014', 'Feb 2014', 'Mar 2014', 'Jan 2014', 'Feb 2014', 'Mar 2014', 'Jan 2014', 'Feb 2014', 'Mar 2014'))
grid.arrange(q2, q1,q3,  nrow = 3)#subplot
#######################################################
#Merge electric and gas, and compare against average temperature and HTDD
r<-merge(e_mean, g_mean, by=c('YearShift','MonthShift')) %>%
  merge(weather, by.x =c('YearShift','MonthShift'), by.y=c('YEAR', 'MONTH'))
compare1<-ggplot(data=r, mapping=aes(x=MonthlyMeanTemperature, y=Consumption_norm.x))+
                   geom_point()+
                   geom_smooth()+
  labs(y='Mean Consumption (KWH Per Square Foot Per Day)', x='Monthly Average Temperature (°F)')
compare2<-ggplot(data=r, mapping=aes(x=MonthlyMeanTemperature, y=Consumption_norm.y))+
  geom_point()+
  geom_smooth()+
  labs(y='Mean Consumption (CCF Per Square Foot Per Day)', x='Monthly Average Temperature (°F)')
compare3<-ggplot(data=r, mapping=aes(x=HTDD, y=Consumption_norm.y))+
  geom_point()+
  geom_smooth()+
  labs(y='Mean Consumption (CCF Per Square Foot Per Day)', x='Heating Degree Days')
compare4<-ggplot(data=r, mapping=aes(x=CLDD, y=Consumption_norm.x))+
  geom_point()+
  geom_smooth()+
  labs(y='Mean Consumption (CCF Per Square Foot Per Day)', x='Cooling Degree Days')
compare1
compare2
compare3
compare4

#Linear model
linearMod <- lm(MonthlyMeanTemperature~Consumption_norm.y, data=r) 
summary(linearMod)$r.squared
linearMod <- lm(HTDD~Consumption_norm.y, data=r) 
summary(linearMod)$r.squared

##################################################################
#Look at addresses which had a repairs project in 2014, and plot the consumption for a few years before and after
#Compare this to a random subsample of non-project addresses (created by Random_Sample.ipynb)
df1<-read_csv('/home/mirabel/Dropbox (GaTech)/CDS-2019-AlbanyHub/subsets of utilities/utilities_nonproj_subsample.csv')
df2<-read_csv('/home/mirabel/Dropbox (GaTech)/CDS-2019-AlbanyHub/subsets of utilities/repairs_utlities_sqft_2014.csv')
df2 = transform(df2, Consumption=as.numeric(Consumption))


df_g1 <- df1 %>% group_by(AddressID, ServiceType, Year, Month, ChargeDate) %>% summarise(TotalConsumption =sum(Consumption), TotalConsPerSQFT = sum(ConsumptionPerSQFT))
df_g2 <- df2 %>% group_by(AddressID, ServiceType, Year, Month, ChargeDate) %>% summarise(TotalConsumption =sum(Consumption), TotalConsPerSQFT = sum(ConsumptionPerSQFT))

for (proj in 1:nrow(df_g1)) {
  month(df_g1$ChargeDate[proj]) = month(df_g1$ChargeDate[proj]) - 1
  if (df_g1$Month[proj] == 1) {
    df_g1$Month[proj] = 12
    df_g1$Year[proj] = df_g1$Year[proj] - 1 
  } else {
    df_g1$Month[proj] = df_g1$Month[proj] - 1 
  }
}

for (proj in 1:nrow(df_g2)) {
  month(df_g2$ChargeDate[proj]) = month(df_g2$ChargeDate[proj]) - 1
  if (df_g2$Month[proj] == 1) {
    df_g2$Month[proj] = 12
    df_g2$Year[proj] = df_g2$Year[proj] - 1 
  } else {
    df_g2$Month[proj] = df_g2$Month[proj] - 1 
  }
}

mean1 <- df_g1 %>% group_by(Month, Year, ServiceType) %>% summarise(MeanNormalCons = mean(TotalConsPerSQFT))
mean2 <- df_g2 %>% group_by(Month, Year, ServiceType) %>% summarise(MeanNormalCons = mean(TotalConsPerSQFT))
mean1$ym <- as.yearmon(paste(mean1$Year, mean1$Month), "%Y %m")
mean2$ym <- as.yearmon(paste(mean2$Year, mean2$Month), "%Y %m")
mean1<-mean1[order(mean1$ym),]
mean2<-mean2[order(mean2$ym),]
mean1<-mean1[3:114,]
mean2<-mean2[3:114,]
e_mean1 <- mean1[mean1$ServiceType == 'RELC',]
g_mean1 <- mean1[mean1$ServiceType == 'RGAS',]
e_mean2 <- mean2[mean2$ServiceType == 'RELC',]
g_mean2 <- mean2[mean2$ServiceType == 'RGAS',]
q1<-ggplot()+
  geom_line(data=e_mean1, mapping=aes(x=ym, y=MeanNormalCons, color='Non-Project'))+
  geom_line(data=e_mean2, mapping=aes(x=ym, y=MeanNormalCons, color='Minor Repairs'))+ 
  expand_limits(y=0)+ 
  theme(legend.title=element_blank(), legend.position = c(0.05,0.15))+
  labs(title ='',
       y='Mean kWh/SQFT',
       x = 'Time')
q2<-ggplot()+
  geom_line(data=g_mean1, mapping=aes(x=ym, y=MeanNormalCons, color='Non-Project'))+
  geom_line(data=g_mean2, mapping=aes(x=ym, y=MeanNormalCons, color='Minor Repairs'))+ 
  expand_limits(y=0)+ 
  theme(legend.title=element_blank(), legend.position = c(0.05,0.15), axis.text.x = element_blank(), axis.ticks.x=element_blank())+
  labs(title ='Gas and Electricity Consumption: Non-Project vs Minor Repairs',
       y='Mean CCF/SQFT',
       x = 'T')
q3<-ggplot(data=weather1, mapping = aes(x=DATE, y=MonthlyMeanTemperature))+
  geom_line()+labs(y='Average Temperature (°F)', x='Time')
#theme(axis.ticks.x=c('Jan 2014', 'Feb 2014', 'Mar 2014', 'Jan 2014', 'Feb 2014', 'Mar 2014', 'Jan 2014', 'Feb 2014', 'Mar 2014', 'Jan 2014', 'Feb 2014', 'Mar 2014'))
grid.arrange(q2, q1,  nrow = 2) 
