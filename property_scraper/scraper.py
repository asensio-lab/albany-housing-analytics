import json
import requests
import pandas as pd
import time
#this file scrapes property data from attomdata.com's 'expanded profile' api, which gives a variety of information about the address
#including square footage and tax assessor data
#Exports the property data as a JSON file

############################################################
#Replace with source of addresses, your api key, and the start and end index within the source of addresses
#likely best not to retrieve more than 1000 addresses at once due to possibility of failure
df = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv')
header = {"apikey":"8adf54d74bfe18c9c634183af053e5b8", "accept":"application/json"}
i_start=18000
i_end  = i_start+1000
############################################################
addresses = df['Address']
address2 = 'Albany, GA'
prop_info = []
no_data_count = 0
i=i_start
while i<i_end:
    address1 = addresses[i]

    parameters = { 'address1':address1, 'address2':address2}
    response = requests.get("https://api.gateway.attomdata.com/propertyapi/v1.0.0/property/expandedprofile", headers=header, params=parameters)
    #SUCCESS
    if response.status_code==200:
        i=i+1
        prop_info.append(response.json()['property'][0])
    #FAILURE
    else:
        no_data_count = no_data_count+1
        prop_info.append([])
        i = i+1
    if i % 100 ==0:
        print(i, "out of",i_end)
print(no_data_count)
f = open('json_dump_'+str(i_start)+"_"+str(i_end-1)+'.json', 'w')
json.dump(prop_info, f)
