import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import re
import os
from fix_addresses_master import *
directory = "~~/Dropbox/CDS-2019-AlbanyHub/Raw-Data/PR 03 - CDBG_CDBG-R Activity Summary Report"
project_typo_fixer = {'ACQUISITIONS':'ACQUISITION', 
            'GENERAL ADMINISTRATION':'ADMINISTRATION',
            'CDBG ADMINISTRATION':'ADMINISTRATION',
            'CAPACITY BUILDING FOR NON PROFITS':'CAPACITY BUILDING FOR NONPROFITS',
            'CAPACITY BUILDING FOR NON':'CAPACITY BUILDING FOR NONPROFITS',
            'COMMERICAL FACADE':'COMMERCIAL FACADE',
            'COMMERCIAL FACADE PROGRAM':'COMMERCIAL FACADE',
            'DISPOSITION 2016':'DISPOSITION',
            'EBONY AND HICKORY LANE PROJECT':'EBONY AND HICKORY LANE',
            'ED REVOLVING LOANS':'ECONOMIC DEVELOPMENT LOANS',
            'EMERGENCY REPAIR':'EMERGENCY REPAIRS',
            'GENERAL PROGRAM ADMINISTRATION':'GENERAL ADMINISTRATION',
            'HISTORIC PRESERVATION PROGRAM':'HISTORIC PRESERVATION',
            'HOMELESS PROGRAM':'HOMELESS PROGRAMS', 
            'HOUSING PROJECTS':'HOUSING',
            'PUBLIC FACILITIES AND IMPROVEMENTS':'PUBLIC FACILITIES',
            'PUBLIC FACILITIES REHABILITATION':'PUBLIC FACILITIES', 
            'PUBLIC FACILITY':'PUBLIC FACILITIES',
            'PUBLIC SERVICE COMPETITIVE GRANTS':'PUBLIC SERVICE',
            'PUBLIC SERVICES':'PUBLIC SERVICE',
            'REHAB ADMINISTRATION':'REHABILITATION',
            'REHABILITATION ADMINISTRATION':'REHABILITATION',
            'RENTAL REHABILITATION':'REHABILITATION',
            'SINGLE UNIT REHAB':'REHABILITATION',
            'VACANT RENTAL REHABILITATIONS':'REHABILITATION',
            'HOMEOWNER REHABILITATION':'REHABILITATION', 
            'HOUSING REHABILITATION':'REHABILITATION',
            'PROJECT COST FOR REHABILITATION':'REHABILITATION',
            'SECTION 108 LAON REPAYMENTS':'SECTION 108 LOANS',
            'SECTION 108 LOAN':'SECTION 108 LOANS', 
            'SECTION 108 LOAN GUARANTEE PROGRAM':'SECTION 108 LOANS',
            'SECTION 108 LOAN PROGRAM':'SECTION 108 LOANS', 
            'SECTION 108 LOAN REPAYMENT':'SECTION 108 LOANS',
            'SECTION 108 LOAN REPAYMENTS':'SECTION 108 LOANS', 
            'KEEP ALBANY DOUGHERTY BEAUTIFUL':'BEAUTIFICATION'
          }
def parse(data):
    #ADDRESS
    locs_re = r'Location:,+"?(.*?)"?,,' #anything after location and between 2+ commas
    locs= re.findall(locs_re, data)
    addrs = locs
    for i in range(len(locs)):
        locs[i] = " ".join(locs[i].split()).upper()
        addrs[i] = locs[i].split(' ALBANY')[0]
        if "UNKNOWN" in addrs[i] or addrs[i] == ',':
            addrs[i] = "UNKNOWN ADDRESS"
    #PLAN YEAR
    pgm_year_re = r'PGM Year:,+(\d\d\d\d)' #grab four digits after PGM YEAR
    pgm_years = re.findall(pgm_year_re, data)
    #IDIS PROJECT AND PROJECT
    #project is formated as (ID) - (TYPE OF PROJECT). type of project can have spaces in it
    project_re = r'Project:,+"?\d+ -((?:\s[\w]+)+)'
    projects = re.findall(project_re, data)
    for i in range(len(projects)):
        projects[i] = " ".join(projects[i].split()).upper()
        if projects[i] in project_typo_fixer.keys():
            projects[i] = project_typo_fixer[projects[i]]
    #(ID) - (TYPE OF PROJECT) - get ID and drop leading zeros
    idis_re = r'Project:,+"?0*(\d+)'
    idis_ids = re.findall(idis_re, data)
    #IDIS ACTIVITY ID
    idisact_re = r'IDIS Activity:,+"?(\d+)' #some number of commas then id. May or may not have a quote first
    idisact_ids = re.findall(idisact_re, data)
    #ACTIVITY STATUS
    completed_re = r'Status:,+(Completed|Canceled|Open) (\d+/\d+/\d+)?'
    completeds = re.findall(completed_re, data)
    status = [a[0] for a in completeds] #either completed or canceled
    status_date = [a[1] for a in completeds] #date this took effect
    #INITIAL FUNDING DATE (new)
    fund_date_re = r'Initial Funding Date:,+(\d+/\d+/\d+)'
    fund_dates = re.findall(fund_date_re, data)
    # match funding
    funding_re = r'Financing((.|\n)*?)Proposed Accomplishment'
    fundings = re.findall(funding_re, data)
    #entry_list: final row of each funding table, containing totals
    entry_list = [entry[0].split("\n")[-2] for entry in fundings]
    #match the dollar amounts: formatted with "$x,xxx.xx" if dollar amount contains a comma, else just $xxx.xx
    amt_re = r'(?:(?:"\$?([\d,.]+)")|([\d.]+))+'
    funded_amts = []
    for entry in entry_list:
        #has totals
        if entry[1] == "T":
            funded_amts.append(re.findall(amt_re, entry)[0]) # has multiple entries, only interested in first 'funded amt'
        #No data on funding, assume 0
        else:
            funded_amts.append(0) 
    #format as integer
    for i in range(len(funded_amts)):
        if funded_amts[i] == 0:
            continue
        elif funded_amts[i][0] =='':
            funded_amts[i] = float(funded_amts[i][1])
        else:
            funded_amts[i] = float("".join(funded_amts[i][0].split(',')))# get rid of , in $x,xxx.xx
    l = len(addrs)
    data_dict = {   "Address":addrs, 
                    "PlanYear":pgm_years, 
                    "Project":projects, 
                    "IDISProjectId":idis_ids, 
                    "IDISActivityID": idisact_ids, 
                    "Status":status,
                    "StatusDate":status_date,
                    "InitialFundingDate":fund_dates,
                    "FundedAmount":funded_amts}
    for key,val in data_dict.items():
        if len(val)!=l:
            raise Exception(key+" does not have the same length as the other entries")
    return pd.DataFrame(data_dict)

df_list = []
for filename in os.listdir(directory):
    if filename.endswith(".csv"): 
        f = open(directory+"/"+filename)
        lines=f.readlines()
        data = " ".join(lines)
        try:
            df_list.append(parse(data))
        except Exception as e:
            print("Filename: "+filename)
            print(e)
            exit(0)
        f.close()
        continue
    else:
        continue
df = pd.concat(df_list, axis=0)
df.to_csv("cdbg_1994-2017.csv")

df2 = df[(df['Project']=='EMERGENCY REPAIRS') | (df['Project']=='ENERGY EFFICIENCY') | (df['Project']=='REHABILITATION')]
unq = df2['Address'].unique()
addr_dict = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/ToDatabase/addr_db.csv')


