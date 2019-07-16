import pandas as pd
#The 'BlockGroup field' retrieved from geocoding is a combination of block and blockgroup
#this file converts the block/block group from geocoding into two separate block and blockgroup columns
#this allows it to be merged with the census data

#The block group is the thousands field, 
#the block is the remainder
df = pd.read_csv("~/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv")

#retrieves block group
def bg(series):
    return series//1000 
#retrieves block
def blk(series):
    return series % 1000
df['temp'] = df['BlockGroup']
#get block group out of combined field
df['BlockGroup'] = df['temp'].apply(bg) 
#get block out of combined field
df['Block'] = df['temp'].apply(blk)
#drop combined field
df.drop(columns=['temp'], inplace=True) 
df.to_csv("/home/mirabel/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv")
