import pandas as pd
from fix_addresses_master import *
#Creates the junction table based on three files from the geocoding folder
#The junction table consists of address, lat/lon, tract, blockgroup, and a unique ID identifier
#Combines all addresses which have been geocoded, and replaces the files which were geocoded incorrectly with their fixed versions

IN_PATH = '~/Dropbox/CDS-2019-AlbanyHub/geocoding/' #read files from
OUT_PATH = '~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/' #output junction table to 
#read in files
df1 = pd.read_csv(IN_PATH+"geo_joined_wtracts.csv")            #addresses retrieved from utilities, with some errors
df2 = pd.read_csv(IN_PATH+"geo_joined_wtracts_resolved.csv")   #The fixed versions of those errors
df3 = pd.read_csv(IN_PATH+"mismatched_housing_resolved.csv")   #addresses retrieved from housing which have no data from utilities

#merge columns from fixed addresses into original
old_name_series = df2['Address'] #addresses which were geocoded incorrectly
df_fixed = df2.drop(columns=['Address']).rename(columns={'fixed_addr':'Address'}) #drop the 'original address' and replace with the fixed name
all0 = df1[~df1['Address'].isin(old_name_series)] # drop columns whose address is in old_name_series (ie, were geocoded incorrectly)
df = pd.concat([all0, df_fixed, df3],sort=False) #combine correct utilities, fixed utilities, and addresses from housing

#split lat, lon coordinates into x and y
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
#unknown and suppressed addresses are codes for housing projects, not found is used to code addresses which were not in the junction table
junct = junct.append({'Address':'UNKNOWN ADDRESS'}, ignore_index=True)
junct = junct.append({'Address':'SUPPRESSED ADDRESS'}, ignore_index=True)
junct = junct.append({'Address':'NOT FOUND'}, ignore_index=True)
#modify the addresses using the master typo fixer dictionary
junct['Address'] = fix_series(junct['Address'])
junct = junct.drop_duplicates(subset ="Address", 
                     keep = 'last')# drop duplicate addresses
junct.index= range(len(junct)) #index is the ID - one value for each row
junct.to_csv(OUT_PATH+"addr_junct_table.csv") #output to csv
