import pandas as pd
df_utilities = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/TotalUtilities.csv')
df_junction_table = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/addr_db.csv')
pd.options.display.max_columns = 15
df_junction_table.columns = ['PrimaryID', 'Address', 'Xcoord', 'Ycoord', 'Tract', 'BlockGroup']
s_junction_table = df_junction_table['Address']
my_dict = df_junction_table.set_index('Address').to_dict()['PrimaryID']
s_utilities = df_utilities['Premise Address']
primaryid_list1 = [None] * 14748395
notfound_list1 = []
counter = 0
for i in range(0, 14748395):
    if counter % 100000 == 0:
        print(str(counter))
    try: #get index of where addresses match
        primaryid_list1[i] = my_dict[s_utilities[i]]
    except KeyError:
        primaryid_list1[i] = -1
        notfound_list1.append(s_utilities[i])
    counter += 1
primaryID1 = pd.Series(primaryid_list1)
notFound1 = pd.Series(notfound_list1)
primaryID1.to_csv("res.csv")