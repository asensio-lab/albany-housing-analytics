import pandas as pd 
from fix_addresses_master import *
#This file assigns the address key based on the junction table to each entry in the housing projects data set
#outputs:   TotalHouse.csv - same file with junction values added
#           house_notfound.csv = the addresses which were not found in the junction table 
#########################################
#Specify paths below this line
#########################################
#PATH to housing projects
df_housing_projects = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/TotalHousingFixed6-19.csv')
#PATH to junction table
df_junction_table = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv')
#OUTPUT PATH
output_path = "~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/"
#########################################
df_junction_table.columns = ['PrimaryID', 'Address', 'Xcoord', 'Ycoord', 'Tract', 'BlockGroup']
my_dict = df_junction_table.set_index('Address').to_dict()['PrimaryID']#maps address to key
s_housing_projects = df_housing_projects['Address']#list of addresses per charge

#Drop unneccesary columns
df_housing_projects.drop(['City', 'State', 'XY Coordinates'], inplace = True, axis = 1)


primaryid_list1 = [None] * len(s_housing_projects)
notfound_dict = {}
counter = 0
s_housing_projects = fix_series(s_housing_projects)   #Fix typos using fix_addresses_master.py
#For each address in utilities, pull address id from dictionary
for i in range(0, len(s_housing_projects)):
    try: #get index of where addresses match
        primaryid_list1[i] = my_dict[s_housing_projects[i]]
    except KeyError:
        primaryid_list1[i] = my_dict['NOT FOUND']
        notfound_dict[i] = s_housing_projects[i]
    counter += 1
#output to file
df_housing_projects['PrimaryID'] = pd.Series(primaryid_list1)
df_housing_projects.to_csv(output_path+"TotalHouse_v03.csv")
df2 = pd.DataFrame(data={'addr':list(notfound_dict.values()), 'loc':list(notfound_dict.keys())})
df2.to_csv(output_path+"house_notfound.csv")