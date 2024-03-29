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
#df = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv')a
df = pd.read_csv('missing.csv')
df['line1'] = df['Address']
df['line2'] = "Albany, GA"
header = {"apikey":"0e98755e809a348b8c7f9f6560349e5e", "accept":"application/json"}
i_start=3000
i_end  = 4000
print(len(df))
############################################################
addresses = df[['line1', 'line2']]
prop_info = []


i=i_start
no_data_count = 0
while i<i_end:

    address1 = addresses.loc[i, 'line1']
    address2 = addresses.loc[i, 'line2']
    # print(i, address1)
    parameters = { 'address1':address1, 'address2':address2}
    response = requests.get("https://api.gateway.attomdata.com/propertyapi/v1.0.0/property/expandedprofile", headers=header, params=parameters)
    #SUCCESS
    if response.status_code==200:
        i=i+1
        prop_info.append(response.json()['property'][0])
    #FAILURE
    elif response.status_code == 400:
        no_data_count = no_data_count + 1
        i=i+1
        prop_info.append(response.json()['status'])
    else:
        #print("Unknown issue: Sleeping for 30s to see if error resolves on its own")
        #print("Failed at", str(i))
        #print(response.text)
        #time.sleep(30)
        no_data_count = no_data_count + 1
        i=i+1
        prop_info.append([])
    if i % 100 ==0:
        print(i, "out of",i_end)
print(str(no_data_count))
f = open('json_dump_missing_noresponse'+str(i_start)+"_"+str(i_end-1)+'.json', 'w')
json.dump(prop_info, f)
