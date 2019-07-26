import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import json
import string
import re
#fixes various issues with housing addresses
PATH_TO_CDBG = "~/Dropbox/CDS-2019-AlbanyHub/Test-Replication/CDBG_Funded_Projects.csv"
PATH_TO_HOME= "~/Dropbox/CDS-2019-AlbanyHub/Test-Replication/HOME_Funded_Projects.csv"
# PATH_TO_CDBG = "~/Dropbox (Amherst College)/CDS-2019-AlbanyHub/Processed-Data/CDBG_Funded_Projects.csv"
# PATH_TO_HOME = "~/Dropbox (Amherst College)/CDS-2019-AlbanyHub/Processed-Data/HOME_Funded_Projects.csv"
#create this file by running build_addr_dict.py
#addr_dict maps the street name to the postfix (i.e. st, dr, etc)
f = open('/home/mirabel/Dropbox (GaTech)/CDS-2019-AlbanyHub/Test-Replication/addr_dict.json', 'r')
addr_dict=json.load(f)

#maps full names to proper abbreviations
#note, this may fail for streets that haven't been seen (IE "North St")
addr_codes = {'STREET':'ST', 'BOULEVARD':'BLVD', 'AVENUE':'AVE', 'LANE':'LN', 'DRIVE':'DR','COURT':'CT', 'ROAD':'RD', 'CIRCLE':'CR', 'TRAIL':'TRL', 'PLACE':'PL', 'TERRACE':'TER'}
dir_codes = {'EAST':'E', 'WEST':'W', 'NORTH':'N', 'SOUTH':'S'}
#NOTE: don cutler sr is in there twice so that it will be replaced properly without creating 'don cutler sr sr'
disp_street_names = {'DON CUTLER SR': 'DON CUTLER','DON CUTLER': 'DON CUTLER SR','JOHNNY WILLIAMS':'JOHNNY W WILLIAMS', 'S GRADY':'GRADY', 'THIRD':'3RD'}

#functions to clean strings
#remove non-alphanumeric characters (eg "St."->"St")
def rm_dot(string): 
    return ''.join(e for e in string if e.isalnum())
#replace common abbreviations
def validate_addr(string):
    if string in addr_codes.keys():
        return addr_codes[string]
    elif string in dir_codes.keys():
        return dir_codes[string]
    else:
        return string
#REGEX string to match addresses
#GROUP 1 = house number, eg 212 or 342 A
#GROUP 2 = street name, eg S Jackson St or Peachtree Terrace
#Group 3 = Apartment number, eg Apt 234 or Unit 7B
re_string = r"^([\dA-Z]+)\s([A-Z\s\d]+?)((?:APTS|APT|UNIT)\s\w+)?\s"
def mod_series(series):
    fixed = series.copy()
    for i in range(len(series)):
        addr = series.loc[i]
        #print(str(i)+'. '+addr)
        parts = addr.split()
        #Standardize address format
        #Convert to all caps and standardize directions
        for j in range(len(parts)):
            parts[j] = validate_addr(rm_dot(parts[j]).upper())
        addr = " ".join(parts)
        #Fix street name
        for st in disp_street_names.keys():
            addr = addr.replace(st, disp_street_names[st])

        m = re.fullmatch(re_string, addr+" ")
        if m is None:
            #print(str(i)+". "+addr+" (not matched)")
            fixed[i] = addr
            continue
        street_number = m.group(1)
        street_name = m.group(2)
        if m.group(3) is not None:
            apt_num = str(m.group(3))
        else:
            apt_num = ''

        parts = street_name.split()
        #Check address format
        #the end part is st, blvd, etc.   
        if parts[-1] in addr_codes.values():
            whole_address = (street_number+" "+street_name+apt_num).replace("  ", " ")
        #else missing the street, boulevard part -> check what the dictionary says it should be
        elif street_name.strip() in addr_dict.keys():
            street_name = street_name+" "+addr_dict[street_name.strip()]
            whole_address = (street_number+" "+street_name+apt_num).replace("  ", " ") #replace double spaces
        else:
            whole_address = addr.replace("  ", " ")
            #print(str(i)+". "+addr)
        fixed[i] = whole_address
    return fixed
    #missing end part, specially formatted address, etc


#read cdbg data and standardize column names
cdbg = pd.read_csv(PATH_TO_CDBG).rename(columns = {'Parcel':'Parcel ID', 'X Y Coordinates':'XY Coordinates', 'Projects':'Project'})
series = cdbg['Address']
fixed = mod_series(series)
#just fix weird parts FOR CDBG
fixed.iloc[334] = "215 BROADWAY CT #13"
fixed.iloc[335] = "215 BROADWAY CT #10"
fixed.iloc[357] = "108 INGLESIDE DR" #so far unknown whether n or s
fixed.iloc[108] = "1206 S MCKINLEY ST"
fixed.iloc[167] = '1401 E CAMPBELL ST/108 CARROLL ST'
fixed.iloc[185] = '2206 HABERSHAM RD APTS 31-40'
cdbg['Address'] = fixed
cdbg.to_csv("CDBG_2007-2017_fixed_address.csv", index=False)

#read home data and standardize column names
home = pd.read_csv(PATH_TO_HOME).rename(columns = {'Parcel':'Parcel ID', 'X Y Coordinates':'XY Coordinates', 'Projects':'Project'})
series = home['Address']
fixed = mod_series(series)
#just fix weird parts FOR HOME
fixed.iloc[118] = "1112A PEACHTREE TER"
fixed.iloc[121] = "305A STATION CROSSING"
fixed.iloc[130] = "2517B CARDINAL DR"
fixed.iloc[173] = "2201C CHAMPAGNE DR"
fixed.iloc[175] = "2200D CHAMPAGNE DR"
fixed.iloc[189] = '803 CARDINAL GROVE CT 1'
fixed.iloc[240] = '509 N WESTOVER BLVD 336'
fixed.iloc[255] = '2710 W OAKRDIGE DR 28'
home['Address'] = fixed
home.to_csv("HOME_2007-2017_fixed_address.csv", index=False)
