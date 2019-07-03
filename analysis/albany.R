library(tidyverse)

house <- read_csv("/Users/davidreynolds/Dropbox/CDS-2019-AlbanyHub/ToDatabase/TotalHouse_v03.csv")
utilities <- read_csv("/Users/davidreynolds/Dropbox/CDS-2019-AlbanyHub/ToDatabase/TotalUtilities.csv")
census <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/Tables/census.csv")

#Prepping the Data
house$X1 <- NULL

names(house) <- str_replace_all(names(house), c(" " = "_"))
names(utilities) <- str_replace_all(names(utilities), c(" " = "_"))

house <- house %>%
  rename(
    primary_id = PrimaryID,
    parcel_id = Parcel_ID,
    address = Address,
    plan_year = Plan_Year,
    idis_project = IDIS_Project,
    project = Project,
    idis_activity_id = IDIS_Activity_ID,
    activity_status = Activity_Status,
    program = Program,
    funded_amount = Funded_Amount,
    draw_amount = Draw_Amount,
    balance =  Balance,
    multihome_type = Multihome_Type,
    multihome = Multihome
  )

utilities <- utilities %>%
  rename(
    charge_id = ChargeID,
    premise = Premise,
    premise_address = Premise_Address,
    customer = Customer,
    service_type = Service_Type,
    service_number = Service_Number,
    service_rate = Service_Rate,
    consumption = Consumption,
    days_of_service = Days_of_Service,
    unit_of_measure = Unit_of_Measure,
    charge_amount = Charge_Amount,
    charge_date = Charge_Date,
    year = Year,
    month = Month,
    day = Day,
    primary_id = PrimaryID
  )

census$block_group_tract <- paste(census$block_group, census$tract, sep = "_")
census <- census %>% select(1:2, block_group_tract, everything())

attach(house)
primary_id <- as.character(primary_id)
parcel_id <- as.character(parcel_id)
address <- as.character(address)
plan_year <- as.factor(plan_year)
idis_project <- as.character(idis_project)
project <- as.factor(project)
idis_activity_id <- as.character(idis_activity_id)
activity_status <- as.factor(activity_status)
program <- as.factor(program)
funded_amount <- as.numeric(funded_amount)
draw_amount <- as.numeric(draw_amount)
balance <- as.numeric(balance)
multihome_type <- as.factor(multihome_type)
multihome <- as.character(multihome)

attach(utilities)
charge_id <- as.character(charge_id)
premise <- as.character(premise)
premise_address <- as.character(premise_address)
customer <- as.character(customer)
service_type <- as.factor(service_type)
service_number <- as.character(service_number)
service_rate <- as.character(service_rate)
consumption <- as.numeric(consumption)
days_of_service <- as.numeric(days_of_service)
unit_of_measure <- as.factor(unit_of_measure)
charge_amount <- as.numeric(charge_amount)
charge_date <- as.character(charge_date)
year <- as.factor(year)
month <- as.factor(month)
day <- as.factor(day)
primary_id <- as.character(primary_id)

attach(census)
tract <- as.factor(tract)
block_group <- as.factor(block_group)
county <- as.factor(county)
block_tract <- as.factor(block_tract)
total_pop <- as.numeric(total_pop)
total_inc <- as.numeric(total_inc)
inc_less_10k <- as.numeric(inc_less_10k)

