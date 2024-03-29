import pandas as pd 
from fix_addresses_master import *
#This file assigns the address key based on the junction table to each entry in the housing projects data set
#outputs:   TotalHouse.csv - same file with junction values added
#           house_notfound.csv = the addresses which were not found in the junction table (coded as NOT FOUND)
#########################################
#Specify paths below this line
#########################################
#PATH to housing projects
#df_housing_projects = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/TotalHousingFixed6-19.csv')
path = '/Users/william/Dropbox (Amherst College)/CDS-2019-AlbanyHub/'
df_housing_projects = pd.read_csv(path + 'ToDatabase/TotalHouse_v03.csv')
#PATH to junction table
#df_junction_table = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv')
df_junction_table = pd.read_csv(path + 'ToDatabase/addr_junct_table.csv')
#OUTPUT PATH
#output_path = "~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/"
output_path = path + 'Raw-Data/test/'
#########################################
df_junction_table.columns = ['PrimaryID', 'Address', 'Xcoord', 'Ycoord', 'Tract', 'BlockGroup', 'Block']
my_dict = df_junction_table.set_index('Address').to_dict()['PrimaryID']#maps each address to its id
print("Shape of Housing Dataframe:", df_housing_projects.shape)
s_housing_projects = df_housing_projects['Address']#lists all addresses in housing projects

#Drop unneccesary columns
#df_housing_projects.drop(['City', 'State', 'XY Coordinates'], inplace = True, axis = 1)

#For each address in housing projects, pull address id from dictionary
primaryid_list1 = [None] * len(s_housing_projects) #the id for each address
notfound_dict = {}
counter = 0
s_housing_projects = fix_series(s_housing_projects)   #Fix typos using fix_addresses_master.py
print("Matching...")
#loop over each address in the dataset and retrieve its id
for i in range(0, len(s_housing_projects)):
    try: 
        primaryid_list1[i] = my_dict[s_housing_projects[i]] #the address has a corresponding id
    except KeyError:
        primaryid_list1[i] = my_dict['NOT FOUND'] #the address does not have a corresponding id: code as not found and keep track of the address
        notfound_dict[i] = s_housing_projects[i]
    counter += 1
#output to file
print("Shape of Housing Dataframe:", df_housing_projects.shape)
df_housing_projects['PrimaryID'] = pd.Series(primaryid_list1) #set the primary id field
df_housing_projects.to_csv(output_path+"TotalHouse_v03.csv")
df2 = pd.DataFrame(data={'addr':list(notfound_dict.values()), 'loc':list(notfound_dict.keys())})#format the list of not found addresses as a pandas dataframe
print("Records not matched:", df2.shape)
df2.to_csv(output_path+"house_notfound.csv")
