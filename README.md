# albany-housing-analytics
Albany Housing Analytics 
# This code processes data and information for the Georgia Tech Albany Hub research project. This is the main repository for data analysis and scientific replication. 


## Note for replication
In the early stages of this project, some raw data was missing (In particular, we did not have data from the month of May for 2012, 2013, 2014, and 2015). We received this data after the addresses had been geocoded and the junction table was made. To replicate the database files exactly, leave these months out when running retrieve_unique_addresses.ipynb. 
## Adding data
If new utility data is added, new addresses which did not exist previously may appear. <br>
To find and add these, run junction_table/add_addresses.ipynb to find any new addresses. Geocode these addresses in MMQGIS and follow the instructions in the documentation to merge them with the block group shapefiles. Then add them to the junction table and rerun steps 2-4 under the header "Address Junction Table".
## Weather
Download the raw LCD data from NOAA following instructions in extended documentation. <br>
Run preprocessing/weather/weather.py on this LCD Data.

## Utility
Download the reformatted utility charges from Sharepoint.<br>
Run utilities_step1 up to the header "Step 1 Stop Here".<br>
...<br>
After the junction table is created, run map_addr_key_utilities.py to associate the address to its primary key.<br>

## Housing Project
Run housing_data_read.ipynb to convert the excel file into a combined csv with both CDBG and HOME funded projects.
Run build_addr_dict.py to build a JSON dictionary which maps street names to their proper endings (eg 'DR' or 'ST') based on the 2012 utility data (under the assumption that all streets are represented in that data set).
Run fix_housing_addresses.py to create HOME/CDBG_2007-2017_fixed_address.csv, which converts addresses to all caps and fixes their endings based on the JSON dictionary.

Generate mismatched_housing_addresses.csv (?)
...<br>
After the junction table is created, run map_addr_key_housing.py to associate the address to its primary key. Set the input file as fix_housing_addresses.py<br>
## Address Junction Table
Run junction_table/retrieve_unique_addresses.ipynb to get the address csvs to be geocoded<br>
Geocode each address CSV using MMQGIS and the Google Maps API (Instructions in full documentation)<br>

1. run create_junction_table_csv.py to create the junction table from the geocoded csvs
   run addr_split_block.py to fix the issue where geocoding records data at block level, where we need block group

2. run map_addr_key_utilities.py to match up the utilities with the junction table. Addresses in the utilities dataset are brought into line with the junction table using functions imported from fix_addresses_master.py. Addresses which still cannot be matched are coded as NOT FOUND

3. run map_addr_key_housing.py to match up the housing projects with the junction table. Addresses in the housing projects dataset are brought into line with the junction table using functions imported from fix_addresses_master.py. Addresses which still cannot be matched are coded as NOT FOUND

4. run map_addr_key_tax.py to match up the tax with the junction table. Addresses in the tax dataset are brought into line with the junction table using functions imported from fix_addresses_master.py. Addresses which still cannot be matched are coded as NOT FOUND

## Real Estate
To retrieve data from api service:<br>
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

## Census Tract and Block Group
Download block-group and tract data from American Fact Finder following instructions in extended documentation. <br>
Run census_processing/process_census.ipynb up to the heading "Census Processing Stop Here

## Analysis
Investigate_Distribution.ipynb<br>
This file investigates the normality of consumption across several different types of houses. <br>
It outlines a procedure to normalize consumption and control for different factors. <br>
It plots gas and electricity consumption, normalized by square footage and not, across albany for a given month. It uses a kernel density plot and a quantile-quantile plot to visualize the distribution of these values. <br>
It collects the mean electric and gas consumption for each month and plots these against the weather. 
Finally it investigates the distribution of consumption for non-project versus project homes.

Weatherization.ipynb<br>
This file shows the linear relationship between gas and htdd <br>
Compares the shifted versus non-shifted dates and demonstrates that shifting the dates is more accurate <br>
Finds addresses which do not have a strong linear relationship between HTDD and gas consumption

Random_Sample.ipynb<br>
Grabs a random sample of SAMPLE_SIZE addresses from a list of utility bills

prepost_plot.ipynb<br>
Compares the consumption before and after a project was completed.<br>
Includes plots that range from Jan-Dec as well as plots in terms of # months before and after project completion
