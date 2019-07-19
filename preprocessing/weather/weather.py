#INPUT: raw files downloaded from NOAA 
#OUTPUT: summary of month LCD_MONTH
import pandas as pd
import datetime as dt
#SPECIFY input files below this line
###################################
PATH = '~/Dropbox (GaTech)/CDS-2019-AlbanyHub/Raw-Data/Weather/'
df = pd.read_csv(PATH+"noaa_LCD.csv", sep=',') # 1-1-2010 TO 5-29-2019
df2 = pd.read_csv(PATH+"noaa_LCD_2.csv", sep=',') #1-1-2001 TO 12-31-2009
###################################
df = pd.concat([df2,df], ignore_index=True)
#df.loc[21861:22361, ['DATE', 'REPORT_TYPE']]
df.head()

#Get summary of day
daysum = df[df['REPORT_TYPE'].str.strip() == 'SOD'].copy()
columns = [a for a in list(daysum) if daysum[a].any()] #get all columns used in SOD
daysum =daysum[columns]

#reformat with month and day as separate columns
def formatdateD(series):
    a = series.split('-')
    b = a[2].split('T')
    return int(b[0])
def formatdateM(series):
    a = series.split('-')
    return int(a[1])
def formatdateY(series):
    a = series.split('-')
    return int(a[0])
#Strip uncertainty value 's' from daily temp records
def asciistrip(series):
    try:
        return float(series)
    except:
        return float(series[:-1])
daysum['MONTH'] = daysum['DATE'].apply(formatdateM)
daysum['YEAR'] = daysum['DATE'].apply(formatdateY)
daysum['DAY'] = daysum['DATE'].apply(formatdateD)


#Get summary of month
monthsum0 = df[df['REPORT_TYPE'].str.strip() == 'SOM'].copy()
columns = [a for a in list(monthsum0) if monthsum0[a].any()] #get all columns used in SOM
monthsum = monthsum0[columns].copy()

#Fix months that were missing
SOM = monthsum[columns[1:35]].copy() #reduce number of columns
               
SOM['MONTH'] = SOM['DATE'].apply(formatdateM) #add month and year columns, separated from date
SOM['YEAR'] = SOM['DATE'].apply(formatdateY)
#fix missing values: append an empty report 
for y in range(2001, 2019):
    for m in range(1,13):
        #if the report for month m and year y does not exist:
        if len(SOM[(SOM['MONTH']==m)&(SOM['YEAR']==y)])==0:
            SOM = SOM.append({'YEAR':y, 'MONTH':m, 'REPORT_TYPE':'SOM'}, ignore_index=True)
SOM.index=range(SOM.shape[0])#reindex

#Use summary of day to complete the missing months (see Weather.ipynb for investigation of this)

#Get Cooling Degree Days
def CDD_monthly(series):
    if series<=65:
        return 0
    else:
        return series-65
#Get Heating Degree Days
def HDD_monthly(series):
    if series>=65:
        return 0
    else:
        return 65-series
missing_ct= SOM['MonthlyMaximumTemperature'].isnull().sum()
#fill these in with SOD
missing_cols = SOM.loc[SOM['MonthlyMaximumTemperature'].isnull(), :]
for vals in missing_cols.itertuples():
    #print(vals.MONTH)
    days = daysum[(daysum['MONTH']==vals.MONTH) &(daysum['YEAR']==vals.YEAR)]
    SOM.loc[vals.Index, 'MonthlyMaximumTemperature'] = days.loc[:,'DailyMaximumDryBulbTemperature'].apply(asciistrip).mean()
    SOM.loc[vals.Index, 'MonthlyMinimumTemperature'] = days.loc[:,'DailyMinimumDryBulbTemperature'].apply(asciistrip).mean()
    SOM.loc[vals.Index, 'MonthlyMeanTemperature'] = days.loc[:,'DailyAverageDryBulbTemperature'].apply(asciistrip).mean()
    SOM.loc[vals.Index, 'CLDD'] = days.loc[:,'DailyAverageDryBulbTemperature'].apply(asciistrip).agg(CDD_monthly).sum()
    SOM.loc[vals.Index, 'HTDD'] = days.loc[:,'DailyAverageDryBulbTemperature'].apply(asciistrip).agg(HDD_monthly).sum()
    SOM.loc[vals.Index, 'DATE'] = dt.datetime.strptime(""+str(int(vals.YEAR))+"-"+str(int(vals.MONTH))+"-01", '%Y-%m-%d')
SOM=SOM.sort_values(by=['YEAR', 'MONTH'])
SOM.index = range(len(SOM))
SOM = SOM[['YEAR', 'MONTH', 'DATE', 'MonthlyMaximumTemperature', 'MonthlyMinimumTemperature', 'MonthlyMeanTemperature', 'CLDD', 'HTDD']]
SOM.to_csv("LCD_month.csv", index=False)