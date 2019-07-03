#master file with function fix_series(s) which fixes all known typos

# safe to use with .replace
addr_fix_typos = {
    'EASTTOWN':'E TOWN',
    'CORDELL AVE':'CORDELL LN',
    'MARY AVE':'MARY ST',
    'W MERCER': 'MERCER',
    'HILLSIDE DR':'HILLSIDE AVE',
    'MID PLACE':'MIDPLACE',
    'COVE CT':'COVES CT',
    'MCKAN': 'MC KAN',
    'EMILY ST': 'EMILY AVE',
    'CAMPBELL AVE':'CAMPBELL ST',
    'BRIARCLIFF':'BRIERCLIFF',
    'N CREEK CT':'NORTHCREEK CT',
    'IPSWITCH':'IP SWITCH',
    'E CAMPBELL ST':'CAMPBELL ST',
    'CAMPBELL ST': 'E CAMPBELL ST',
    'EXPRESS WAY':'EXPY',
    'LIBERTY SE EXPY':'LIBERTY EXPY',
    'CHARLES LN':'CHARLES CT',
    'JOSHUA RD':'JOSHUA ST',
    'MILLBROOK RD':'MILLBROOKE RD',
    'SANDLEWOOD':'SANDALWOOD',
    'BONNYVIEW':'BONNY VIEW',
    'BONNY VIEW CT': 'BONNY VIEW AVE',
    'CRESENT':'CRESCENT',
    'COCHRAN ST':'COCHRAN AVE',
    'RIVERVIEW DR':'RIVERVIEW CIR',
    'MARTIN LUTHER JR DR':'MARTIN LUTHER KING JR DR',
    'HILLSIDE AVE':'HILLSIDE DR',
    "CHAMPAGNE LN":"CHAMPAGNE DR",
    " ROADWAY ST":' ROADWAY RD',
    'JOHNNY WILLIAMS':'JOHNNY W WILLIAMS',
    'E OGLETHORPE E BLVD':'E OGLETHORPE BLVD',
    'W WADDELL W AVE':'W WADDELL AVE',
    'N HALEY ST': 'HALEY ST',
    'Swaggot Road':'SWAGGOTT RD'
    
    
}
#NOT safe to use with replace
addr_fix_entries = {
    'LAKEVIEW':'LAKEVIEW RD',
    'W BROAD':'W BROAD AVE',
    'CORN':'CORN AVE',
    'SWIFT':'SWIFT ST',
    '4502 MILES':'4502 MILES AVE',
    '1064 US 19 S':'1064 US HIGHWAY 19 S',
    '905 U.S. 19 S':'905 US HIGHWAY 19 S',
    '1419 HIGHLAND AVE':'1419 W HIGHLAND AVE',
    '108 INGLESIDE DR': '108 S INGLESIDE DR',
    '207 INGLESIDE DR':'207 N INGLESIDE DR',
    '2620 S MADISON':'2620 S MADISON ST',
    '208 S MADISON':'208 S MADISON ST',
    '2420 DUNDEE':'2420 DUNDEE CT',
    '231 E OGLETHORPE AVE': '231 E OGLETHORPE BLVD',
    '120 BLAYLOCK ST': '120 OLD BLAYLOCK LN'
}
def fix_addr(series):
    for key, val in addr_fix_typos.items():
        series = series.replace(key, val)
    for key, val in addr_fix_entries.items():
        if series == key:
            series = val
    return series

def fix_series(series):
    series = series.apply(fix_addr)
    return series
