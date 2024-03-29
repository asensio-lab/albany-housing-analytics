import pandas as pd 
import numpy as np
import json
#builds a dict mapping street addresses to their suffix (st, dr, etc)
#and exports to json
#PATH_TO_CSV = "~/Dropbox/CDS-2019-AlbanyHub/Processed-Data/Totals2012.csv"
PATH_TO_CSV = "~/Dropbox (GaTech)/CDS-2019-AlbanyHub/Test-Replication/Totals2012.csv"
df = pd.read_csv(PATH_TO_CSV, sep=',')

addresses = df.loc[:,'Premise Address'].copy()
# get the end part of each street in Albany (hopefully)
addr_dict = {} #Connect each street name to it's end part (IE ACORN -> ST)

for d in addresses:
    if isinstance(d, str):
        d = d.upper()
        add1 = d.split('ALBANY')
        if len(add1)==1:
            add1 = d.split('LEESBURG')
        add2 = add1[0].split()
        st_name = add2[1:-1]
        st_end = add2[-1]
        if " ".join(st_name) not in addr_dict.keys():
            addr_dict[" ".join(st_name)] = st_end
f = open("addr_dict.json", 'w')
json.dump(addr_dict, f)
