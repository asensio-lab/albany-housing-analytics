import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#### This file separates the date field and adds a 'day' column
#### Also converts addresses to upper case and specifies what columns are needed
#### Also removes the double space in the address field
#### Note: this script is repeatable, IE you can run it on the data multiple times
#### and it will return the same csv each time
pathstring="~/Dropbox/CDS-2019-AlbanyHub/Processed-Data/Totals"
def recode(series):
    if series == 'Jan':
        return 1
    elif series == 'Feb':
        return 2
    elif series== 'Mar':
        return 3
    elif series == 'Apr':
        return 4
    elif series== 'May':
        return 5
    elif series == 'Jun':
        return 6
    elif series== 'Jul':
        return 7
    elif series == 'Aug':
        return 8
    elif series== 'Sep':
        return 9
    elif series == 'Oct':
        return 10
    elif series== 'Nov':
        return 11
    elif series == 'Dec':
        return 12
    else:
        return series
def day(series):
    a = series.split('-')
    return int(a[2])
def caps(series):
    return series.upper()
def singlespace(series):
    a = series.split()
    return " ".join(a)
def fix_address_misspellings(series):
    if series=='214 E OGLETHORPE E BLVD':
        return '214 E OGLETHORPE BLVD'
    elif series=='231 E OGLETHORPE AVE':
        return '231 E OGLETHORPE BLVD'
    elif series=='1717 E OGLETHORPE E BLVD':
        return '1717 E OGLETHORPE BLVD'
    elif series == '1908 E OGLETHORPE E BLVD':
        return '1908 E OGLETHORPE BLVD'
    elif series == '2116 W WADDELL W AVE':
        return '2116 W WADDELL AVE'
    elif series == '614 ROADWAY ST':
        return '614 ROADWAY RD'
    elif series == '603 HALEY ST':
        return '603 N HALEY ST'
    elif series == '2620 S MADISON':
        return '2620 S MADISON ST'
    elif series == '208 S MADISON':
        return '208 S MADISON ST'
    elif 'N HALEY ST' in series:
        return series.replace('N HALEY ST', 'HALEY ST')
    elif 'EASTTOWN' in series:
        return series.replace('EASTTOWN', 'E TOWN')
    else:
        return series
for i in range(2012, 2020):
    df=pd.read_csv(pathstring+str(i)+".csv")
    df = df.loc[df['Premise Address'].notnull(),:]
    df2 = df.copy()
    #change jan/feb/mar... to 1/2/3...
    df2['Month']=df['Month'].apply(recode)
    #add a day column eg
    df2['Day'] = df['Charge Date'].apply(day)
    #make sure that the address is correct
    df2['Premise Address'] = df['Premise Address'].apply(caps).apply(singlespace).apply(fix_address_misspellings)
    #specify the columns we need
    df2 = df2[['Premise', 'Premise Address', 'Customer',
           'Service Type', 'Service Number', 'Service Rate', 'Consumption',
           'Days of Service', 'Unit of Measure', 'Charge Amount', 'Charge Date',
           'Year', 'Month', 'Day']]
    df2.to_csv("Totals"+str(i)+".csv")