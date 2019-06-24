import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
# Takes the utilities in processed-data and separates them into different files by type
pathstring="~/Dropbox/CDS-2019-AlbanyHub/Processed-Data/Totals"
df_array = []
#separate the service types into different utility categories
ELEC = ['RELC', 'DELC', 'CELC', 'GELC', 'UELC']
GAS = ['RGAS', 'CGAS', 'IGAS', 'FGAS']
SEWER = ['RSWR', 'CSWR', 'MSWR', 'USWR']
WATER = ['RWTR', 'CWTR', 'GWTR', 'WCOM', 'STRM']
TELECOM = ['RTEL', 'CTEL', 'SCLT', 'SLCM', 'SLRE']
GARBAGE = ['RGAR', 'CGAR', 'GGAR']
MISC = ['CO', 'TEMP']
type_arrs = [ELEC, GAS, SEWER, WATER, TELECOM, GARBAGE, MISC]
type_names = ['ELEC', 'GAS', 'SEWER', 'WATER', 'TELECOM', 'GARBAGE', 'MISC']

#get all the records for each category and prints them to a csv
#NOTE: generates over 1GB of data
for j in range(len(type_names)):
    df_array = []
    csv_name = "utility_2012_2019_"+type_names[j]+".csv"
    for i in range(2012, 2020):
        df_water = pd.read_csv(pathstring+str(i)+".csv")
        df_water = df_water.loc[df_water['Service Type'].isin(type_arrs[j]), :]
        df_array.append(df_water)
    df = pd.concat(df_array)
    df.to_csv(csv_name)