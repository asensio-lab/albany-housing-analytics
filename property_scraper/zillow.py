import json
import requests
import pandas as pd
#File which shows how to retrieve information for a single address on zillow.com
#Replace zwsid with your zillow id
zwsid = "X1-ZWz17vizj04ft7_8xo7s"
addr = '1702 W OAKRIDGE DR'
csz = 'ALBANY GA 31707' #not sure if zipcode is needed
rz = True


params = {'zws-id':zwsid, 'address':addr, 'citystatezip':csz, 'rentzestimate':rz}

response = requests.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm", )
