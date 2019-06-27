import pandas as pd
#this file converts the block/block group from geocoding into block and block group
df = pd.read_csv("C:\\Users\\Mirabel\\Downloads\\addr_junct_table.csv")

def bg(series):
    return series//1000
def blk(series):
    return series % 1000
df['temp'] = df['BlockGroup']
df['BlockGroup'] = df['temp'].apply(bg)
df['Block'] = df['temp'].apply(blk)
df.drop(columns=['temp'], inplace=True)
df.to_csv("C:\\Users\\Mirabel\\Downloads\\addr_junct_table.csv")