import pandas as pd
from fix_addresses_master import *
#Creates the junction table based on three files from the geocoding folder
PATH = '~/Dropbox/CDS-2019-AlbanyHub/geocoding/'
#read in files
df1 = pd.read_csv(PATH+"geo_joined_wtracts.csv")            #original addresses, with some errors
df2 = pd.read_csv(PATH+"geo_joined_wtracts_resolved.csv")   #The fixed versions of those errors
df3 = pd.read_csv(PATH+"mismatched_housing_resolved.csv")   #geocoded addresses from housing which were not in the originals

#merge columns from fixed addresses into original
old_name_series = df2['Address'] #addresses which were geocoded incorrectly
df_fixed = df2.drop(columns=['Address']).rename(columns={'fixed_addr':'Address'}) #addresses after fixed
all0 = df1[~df1['Address'].isin(old_name_series)] # drop columns whose address is in old_name_series (ie, were geocoded incorrectly)
df = pd.concat([all0, df_fixed, df3],sort=False) #ALL 3 datasets combined

#split coordinates into x and y
def splitloc1(series):
    a = series.split(',')
    return a[0]
def splitloc2(series):
    a = series.split(',')
    return a[1]
df['Xcoord'] = df['addrlocat'].apply(splitloc1)
df['Ycoord'] = df['addrlocat'].apply(splitloc2)

#specify the fields we want to keep, and their names
junct = df[['Address', 'Xcoord', 'Ycoord', 'TRACTCE10', 'BLOCKCE10']].rename(columns={'TRACTCE10':'Tract', 'BLOCKCE10':'BlockGroup'})
#add fields for unknown and suppressed address
junct = junct.append({'Address':'UNKNOWN ADDRESS'}, ignore_index=True)
junct = junct.append({'Address':'SUPPRESSED ADDRESS'}, ignore_index=True)
junct = junct.append({'Address':'NOT FOUND'}, ignore_index=True)
#modify the addresses
junct['Address'] = fix_series(junct['Address'])
junct = junct.drop_duplicates(subset ="Address", 
                     keep = 'last')
junct.index= range(len(junct))
junct.to_csv("addr_junct_table.csv")