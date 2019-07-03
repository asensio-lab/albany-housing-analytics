import pandas as pd
import os
#### This file reads the utilities from the raw data and combines them as a single csv.
#### Also fixes all fields

#### 1. Read in all files
directory = "~/Dropbox/CDS-2019-AlbanyHub/Raw-Data/Utilities"
df_list = []
for filename in os.listdir(directory):
    if filename.endswith(".csv"): 
        df = pd.read_csv(directory+"/"+filename, sep=';')
        df_list.append(df)
        continue
    else:
        continue
df = pd.concat(df_list)

#### 2. Split address
def addr_split(series):
    series = series.upper()
    a = series.split('ALBANY')
    if len(a) == 1:
        a = series.split('LEESBURG')
    return a[0]
df['Premise Address'] = df['Premise Address'].apply(addr_split)
