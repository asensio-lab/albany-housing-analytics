import os
import pandas as pd
directory = "~~/Dropbox/CDS-2019-AlbanyHub/Raw-Data/PR 03 - CDBG_CDBG-R Activity Summary Report"
for filename in os.listdir(directory):
    if filename.endswith(".xlsx"): 
        df = pd.read_excel(directory+"/"+filename)
        fname2 = "cdbg_"+filename[-10:-6]+".csv"
        df.to_csv(directory+"/"+fname2, sep=",", index=False) 
        continue
    else:
        continue

