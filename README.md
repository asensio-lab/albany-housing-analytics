# albany-housing-analytics
Albany Housing Analytics 
# This code processes data and information for the Georgia Tech Albany Hub research project. This is the main repository for data analysis and scientific replication. 

## Weather
Download the raw LCD data from NOAA
Run preprocessing/weather/weather.py on this LCD Data

## Utility
Download the reformatted utility charges from Sharepoint
Run utilities_step1 up to the header "Step 1 Stop Here"

## Housing Project


## Address Junction Table
Run junction_table/retrieve_unique_addresses.ipynb to get the address csvs to be geocoded
Geocode each address CSV using MMQGIS and the Google Maps API (Instructions in full documentation)

1. run create_junction_table_csv.py to create the junction table from the geocoded csvs
   run addr_split_block.py to fix the issue where geocoding records data at block level, where we need block group

2. run map_addr_key_utilities.py to match up the utilities with the junction table. Addresses in the utilities dataset are brought into line with the junction table using functions imported from fix_addresses_master.py. Addresses which still cannot be matched are coded as NOT FOUND

3. run map_addr_key_housing.py to match up the housing projects with the junction table. Addresses in the housing projects dataset are brought into line with the junction table using functions imported from fix_addresses_master.py. Addresses which still cannot be matched are coded as NOT FOUND

4. run map_addr_key_tax.py to match up the tax with the junction table. Addresses in the tax dataset are brought into line with the junction table using functions imported from fix_addresses_master.py. Addresses which still cannot be matched are coded as NOT FOUND

## Real Estate
To retrieve data from api service:
1. RUN scraper.py, replacing the api key, setting the file the addresses are being read from to 'addr_junct_table.csv', and setting the api endpoint to 'extendedprofile'. Place the resulting .json files in Processed-Data/attom-json
2. RUN property_data.ipynb, up to to the "Data Exploration" sub heading, generating:
property_data.csv: certain chosen fields from the property data exported into a dataframe
missing.csv: The addresses which could not be retrieved from the api or which could not be matched with the address junction table
3. RUN scraper.py, setting the file to 'missing.csv'. Place the .json files in Processed-Data/attom-json/missing
4. RUN property_data.ipynb from the "Read missing back in" subheading. 
	a) Split the results into 'found', which were retrieved on the second run-through and 'missing_list', which still could not be retrieved.
	b) In found, compare the coordinates retrieved from the api service to the coordinates of the address used to query. If it seems that the api found the wrong location, drop this address. Otherwise, add to a new dataframe dfp2.
	c) In missing_list, split the non-found addresses by the error code. If the error was "System Not Responding", the address can be retrieved by querying the 'BasicProfile' rather than 'ExtendedProfile' endpoint. Export the addresses with this error code to a csv, then run scraper.py changing the file to this csv and the api endpoint to basicprofile. 
	d) Move the results of step c) to /Processed-Data/attom_json/missing/noresponse/, then retrieve and add them to a new dataframe dfp3.
	e) Concatenate dfp, dfp2, and dfp3 into a single dataframe, dfp_all, and export to property_data.csv

