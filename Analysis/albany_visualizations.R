library(tidyverse)
library(ggplot2)

junction <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv")
blockgroup <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/full_blockgroup.csv")
tract <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/full_tract.csv")
property <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/property_data.csv")
house <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/TotalHouse_v06.csv")
tax <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/TotalTax_v03.csv")
utilities <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/TotalUtilities_v03.csv")

