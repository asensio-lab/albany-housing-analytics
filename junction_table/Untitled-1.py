import pandas as pd
from fix_addresses_master import *
#This file assigns the address key based on the junction table to each entry in the utilities data set
#outputs:   res.csv = the key associated with each row of the utilities (or the key for NOT FOUND)
#           err.csv = the addresses which were not found in the junction table 
#PATH TO UTILITIES TABLE with addresses still included
df_utilities = pd.read_csv('~/Documents/cds/TotalUtilities.csv')
#PATH TO ADDRESS JUNCTION TABLE created in create_junction_table.py
df_junction_table = pd.read_csv('temp.csv')
#make sure column names are correct
df_junction_table.columns = ['PrimaryID', 'Address', 'Xcoord', 'Ycoord', 'Tract', 'BlockGroup']
my_dict = df_junction_table.set_index('Address').to_dict()['PrimaryID']#maps address to key
s_utilities = df_utilities['Premise Address']#list of addresses per charge
primaryid_list1 = [None] * len(s_utilities)
notfound_dict = {}
counter = 0
s_utilities = fix_series(s_utilities)   #Fix typos using fix_addresses_master.py
#For each address in utilities, pull address id from dictionary
for i in range(0, len(s_utilities)):
    if counter % 100000 == 0:
        print(str(counter))
    try: #get index of where addresses match
        primaryid_list1[i] = my_dict[s_utilities[i]]
    except KeyError:
        primaryid_list1[i] = my_dict['NOT FOUND']
        notfound_dict[i] = s_utilities[i]
    counter += 1
#output to file
df = pd.DataFrame(data={'id':primaryid_list1})
df.to_csv("res.csv", index=False)
df2 = pd.DataFrame(data={'addr':list(notfound_dict.values()), 'loc':list(notfound_dict.keys())})
df2.to_csv("err.csv")