import json
import requests
import pandas as pd
zwsid = "X1-ZWz17vizj04ft7_8xo7s"
addr = '1702 W OAKRIDGE DR'
csz = 'ALBANY GA 31707'
rz = True


params = {'zws-id':zwsid, 'address':addr, 'citystatezip':csz, 'rentzestimate':rz}

response = requests.get("http://www.zillow.com/webservice/GetDeepSearchResults.htm", )