import pandas as pd
#This file assigns the address key based on the junction table to each entry in the utilities data set
#outputs:   res.csv = the key associated with each row of the utilities (or the key for NOT FOUND)
#           err.csv = the addresses which were not found in the junction table 
#PATH TO UTILITIES TABLE with addresses still included
df_utilities = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/TotalUtilities.csv')
#PATH TO ADDRESS JUNCTION TABLE created in create_junction_table.py
df_junction_table = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/addr_db_old.csv')
#make sure column names are correct
df_junction_table.columns = ['PrimaryID', 'Address', 'Xcoord', 'Ycoord', 'Tract', 'BlockGroup']
my_dict = df_junction_table.set_index('Address').to_dict()['PrimaryID']#maps address to key
s_utilities = df_utilities['Premise Address'] #list of addresses
primaryid_list1 = [None] * 14748395
notfound_dict = {}
counter = 0

# def rename_all(addr):
#     addr = addr.replace("SANDLEWOOD","SANDALWOOD").replace("CRESENT", "CRESCENT").replace("MILES", "MILES AVE").replace("EMILY ST", 'EMILY AVE').replace("LIBERTY SE EXPY", 'LIBERTY EXPY').replace("LIBERTY EXPRESS WAY", 'LIBERTY EXPY')
#     addr = addr.replace("MARTIN LUTHER JR", 'MARTIN LUTHER KING JR').replace("CAMPBELL", "E CAMPBELL").replace("MID PLACE", "MIDPLACE").replace("IPSWITCH", 'IP SWITCH')
#     addr = addr.replace("CORN", "CORN AVE").replace("SWIFT", "SWIFT ST").replace("W BROAD", 'W BROAD AVE').replace("LAKEVIEW", 'LAKEVIEW RD')
#     addr = addr.replace("COVE", "COVES").replace("BONNY VIEW CT", 'BONNY VIEW AVE').replace("MILLBROOK", 'MILLBROOKE')
#     addr = addr.replace("1300 E CAMPBELL AVE", "1300 E CAMPBELL ST").replace("JOSHUA RD", 'JOSHUA ST').replace("1064 US 19 S", '1064 US HIGHWAY 19 S').replace('905 U.S. 19 S','905 US HIGHWAY 19 S' )
#     addr = addr.replace("MCKAN", "MC KAN").replace("BRIARCLIFF", 'BRIERCLIFF').replace("DUNDEE", 'DUNDEE CT').replace("N CREEK", 'NORTHCREEK')
#     return addr
for i in range(0, 14748395):
    if counter % 100000 == 0:
        print(str(counter))
    try: #get index of where addresses match
        primaryid_list1[i] = my_dict[s_utilities[i]]
    except KeyError:
        try:
            primaryid_list1[i] = my_dict[rename_all(s_utilities[i])]
        except KeyError:
            primaryid_list1[i] =30732 #UNKNOWN ADDRESS
            notfound_dict[i] = s_utilities[i]
    counter += 1
primaryID1 = pd.Series(primaryid_list1)
#print(len(notFound1))
print(len(primaryID1))
df = pd.DataFrame(data={'id':primaryid_list1})
df.to_csv("res.csv")
df2 = pd.DataFrame(data={'addr':list(notfound_dict.values()), 'loc':list(notfound_dict.keys())})
df2.to_csv("err.csv")