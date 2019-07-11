import pandas as pd
from fix_addresses_master import *

path = '/Users/william/Dropbox (Amherst College)/CDS-2019-AlbanyHub/'


if __name__ == '__main__':
    df_util = pd.read_csv(path + 'ToDatabase/TotalUtilities.csv')
    s_util_addr = df_util['Premise Address']
    