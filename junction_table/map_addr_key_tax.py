import pandas as pd
from fix_addresses_master import *
#This file assigns the address key based on the junction table to each entry in the tax data set
#outputs:   TotalTax.csv - same file with junction values added
#           tax_notfound.csv = the addresses which were not found in the junction table 
#########################################
#Specify paths below this line
#########################################
#PATH TO TAX TABLE with addresses still included
PATH_TO_TAX = '~/Dropbox (Amherst College)/CDS-2019-AlbanyHub/Raw-Data/TotalTax.csv'
#PATH TO ADDRESS JUNCTION TABLE created in create_junction_table.py
df_junction_table = pd.read_csv('~/Dropbox (Amherst College)/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv')
#OUTPUT PATH
OUT_PATH='~/Dropbox (Amherst College)/CDS-2019-AlbanyHub/Raw-Data/'
#########################################
#make sure column names are correct
df_tax = pd.read_csv(PATH_TO_TAX)
print("Shape of tax dataframe:", df_tax.shape)
df_junction_table.columns = ['PrimaryID', 'Address', 'Xcoord', 'Ycoord', 'Tract', 'BlockGroup', 'Block']
my_dict = df_junction_table.set_index('Address').to_dict()['PrimaryID']#maps address to key
s_tax = df_tax['FULL_ADDRESS']#list of addresses per charge
primaryid_list1 = [None] * len(s_tax)
notfound_dict = {}
counter = 0
print(type(s_tax))
s_tax = fix_series(s_tax)   #Fix typos using fix_addresses_master.py #NOT SURE ABOUT THIS
print("Matching...")
#For each address in utilities, pull address id from dictionary
for i in range(0, len(s_tax)):
    if counter % 100000 == 0:
        print(str(counter))
    try: #get index of where addresses match
        primaryid_list1[i] = my_dict[s_tax[i]]
    except KeyError:
        primaryid_list1[i] = my_dict['NOT FOUND']
        notfound_dict[i] = s_tax[i]
    counter += 1
#output to file
df_tax['PrimaryID'] = pd.Series(primaryid_list1)
df_tax['FULL_ADDRESS'] = s_tax
print("Shape of tax dataframe:", df_tax.shape)
df_tax.to_csv(PATH_TO_TAX)
df2 = pd.DataFrame(data={'addr':list(notfound_dict.values()), 'loc':list(notfound_dict.keys())})
print("Not found records:", df2.shape)
df2.to_csv(OUT_PATH+"tax_notfound.csv", index=False)
