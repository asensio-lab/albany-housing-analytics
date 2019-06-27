import json
import requests
import pandas as pd
import time
df = pd.read_csv('/Users/davidreynolds/Dropbox/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv')
df['line1'] = df['Address']
df['line2'] = "Albany, GA"
addresses = df[['line1', 'line2']]
prop_info = []
header = {"apikey":"fd68ecdf6751c88e5a399f1a35915ab2", "accept":"application/json"}
i_start=12001
i_end  = i_start+1000
no_data_count = 0
i=i_start
while i<i_end:
    address1 = addresses.loc[i, 'line1']
    address2 = addresses.loc[i, 'line2']
    parameters = { 'address1':address1, 'address2':address2}
    response = requests.get("https://api.gateway.attomdata.com/propertyapi/v1.0.0/property/expandedprofile", headers=header, params=parameters)
    #SUCCESS
    if response.status_code==200:
        i=i+1
        prop_info.append(response.json()['property'][0])
    #FAILURE
    else:
        #print(response.text)
        #time.sleep(30)
        no_data_count = no_data_count + 1
        i=i+1
        prop_info.append([])
    if i % 100 ==0:
        print(i, "out of",i_end)
f = open('json_dump_'+str(i_start)+"_"+str(i_end-1)+'.json', 'w')
json.dump(prop_info, f)
