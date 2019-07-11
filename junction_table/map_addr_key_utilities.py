import pandas as pd
from fix_addresses_master import *
#This file assigns the address key based on the junction table to each entry in the utilities data set
#outputs:   TotalUtilities.csv - same file with junction values added
#           utilities_notfound.csv = the addresses which were not found in the junction table 
#########################################
#Specify paths below this line
#########################################
#PATH TO UTILITIES TABLE with addresses still included
#PATH_TO_UTILITIES = '/home/mirabel/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/TotalUtilities.csv'
PATH_TO_UTILITIES = '/Users/william/Dropbox (Amherst College)/CDS-2019-AlbanyHub/ToDatabase/TotalUtilities.csv'
#PATH TO ADDRESS JUNCTION TABLE created in create_junction_table.py
df_junction_table = pd.read_csv('~/Dropbox (Amherst College)/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv')
#OUTPUT PATH
#OUT_PATH='/Users/william/Dropbox (Amherst College)/CDS-2019-AlbanyHub/Raw-Data/test/TotalUtilities_v2.csv'
OUT_PATH='/Users/william/Dropbox (Amherst College)/CDS-2019-AlbanyHub/Raw-Data/test/'
#########################################
#make sure column names are correct
df_utilities = pd.read_csv(PATH_TO_UTILITIES)
df_junction_table.columns = ['PrimaryID', 'Address', 'Xcoord', 'Ycoord', 'Tract', 'BlockGroup', 'Block']
my_dict = df_junction_table.set_index('Address').to_dict()['PrimaryID']#maps address to key
s_utilities = df_utilities['Premise Address']#list of addresses per charge
primaryid_list1 = [None] * len(s_utilities)
notfound_dict = {}
counter = 0
print(type(s_utilities))
#s_utilities = fix_addr(s_utilities)
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
df_utilities['PrimaryID'] = pd.Series(primaryid_list1)
df_utilities['Premise Address'] = s_utilities
#df_utilities.to_csv(PATH_TO_UTILITIES , index_label="ChargeID")
df_utilities.to_csv(OUT_PATH + "utilities_v2.csv", index_label = "ChargeID")
df2 = pd.DataFrame(data={'addr':list(notfound_dict.values()), 'loc':list(notfound_dict.keys())})
df2.to_csv(OUT_PATH+"utilities_notfound.csv", index=False)
