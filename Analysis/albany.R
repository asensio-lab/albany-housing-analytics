library(tidyverse)

house <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/TotalHouse_v06.csv")
utilities <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/subsets of utilities/repairs_utilities.csv")
tract <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/full_tract.csv")
block_group <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/full_blockgroup.csv")
tax <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/TotalTax_v03.csv")
junction <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv")
avg_elec <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/subsets of utilities/avg_elec.csv")

#Prepping the Data
house$X1 <- NULL
house$IDIS_ACTIVITY_ID <- NULL
house$IDIS_ACTIVITY_ID_FIRST <- NULL
house$IDIS_ACTIVITY_ID_END <- NULL
house$INIT_DATE <- NULL
house$STAT_DATE <- NULL

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

View(house)
View(utilities)
View(tract)
View(block_group)
View(tax)
View(junction)
View(avg_elec)

#Analysis of charge_amount and consumption
attach(utilities)
fit <- lm(charge_amount ~ service_type + consumption + days_of_service + year)
summary(fit)

fit <- lm(charge_amount ~ days_of_service)
summary(fit)

fit <- lm(charge_amount ~ year)
summary(fit)

fit <- lm(consumption ~ service_type + days_of_service + charge_amount + year)
summary(fit)

fit <- lm(consumption ~ days_of_service)
summary(fit)

fit <- lm(consumption ~ year)
summary(fit)

anova <- aov(charge_amount ~ service_type + year)
summary(anova)

anova <- aov(charge_amount ~ service_type)
summary(anova)

anova <- aov(charge_amount ~ year)
summary(anova)

anova <- aov(consumption ~ service_type + year)
summary(anova)

anova <- aov(consumption ~ service_type)
summary(anova)

anova <- aov(consumption ~ year)
summary(anova)

#Testing Individual Projects
utilities_1 <- utilities[which(premise_address == "1321 EDGERLY AVE" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_1)
summary(fit)
plot(utilities_1$charge_date, utilities_1$consumption)
abline(fit)

utilities_2 <- utilities[which(premise_address == "1406 6TH AVE" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_2)
summary(fit)
plot(utilities_2$charge_date, utilities_2$consumption)
abline(fit)

utilities_3 <- utilities[which(premise_address == "1901 GREENVALE RD" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_3)
summary(fit)
plot(utilities_3$charge_date, utilities_3$consumption)
abline(fit)

utilities_4 <- utilities[which(premise_address == "2004 W WHITNEY AVE" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_4)
summary(fit)
plot(utilities_4$charge_date, utilities_4$consumption)
abline(fit)

utilities_5 <- utilities[which(premise_address == "2009 INDICA TRL" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_5)
summary(fit)
plot(utilities_5$charge_date, utilities_5$consumption)
abline(fit)

utilities_6 <- utilities[which(premise_address == "2011 COVE CT" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_6)
summary(fit)
plot(utilities_6$charge_date, utilities_6$consumption)
abline(fit)

utilities_7 <- utilities[which(premise_address == "2204 S WASHINGTON ST" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_7)
summary(fit)
plot(utilities_7$charge_date, utilities_7$consumption)
abline(fit)

utilities_8 <- utilities[which(premise_address == "302 ENTERPRISE DR" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_8)
summary(fit)
plot(utilities_8$charge_date, utilities_8$consumption)
abline(fit)

utilities_9 <- utilities[which(premise_address == "713 ANDOVER LN" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_9)
summary(fit)
plot(utilities_9$charge_date, utilities_9$consumption)
abline(fit)

utilities_10 <- utilities[which(premise_address == "624 JEFFERIES AVE" & service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_10)
summary(fit)
plot(utilities_10$charge_date, utilities_10$consumption)
abline(fit)

utilities_11 <- utilities[which(premise_address == "1321 EDGERLY AVE" & service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_11)
summary(fit)
plot(utilities_11$charge_date, utilities_11$consumption)
abline(fit)

utilities_12 <- utilities[which(premise_address == "1406 6TH AVE" & service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_12)
summary(fit)
plot(utilities_12$charge_date, utilities_12$consumption)
abline(fit)

utilities_13 <- utilities[which(premise_address == "1901 GREENVALE RD" & service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_13)
summary(fit)
plot(utilities_13$charge_date, utilities_13$consumption)
abline(fit)

utilities_14 <- utilities[which(premise_address == "2004 W WHITNEY AVE" & service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_14)
summary(fit)
plot(utilities_14$charge_date, utilities_14$consumption)
abline(fit)

utilities_15 <- utilities[which(premise_address == "624 JEFFERIES AVE" & service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_20)
summary(fit)
plot(utilities_15$charge_date, utilities_15$consumption)
abline(fit)

#Emergency Repairs, 2015, RELC
house_emergency <- house[which(project == "Emergency Repairs"), ]
house_emergency_2015 <- house_emergency[which(house_emergency$plan_year == 2015), ]
utilities_emergency_2015_relc <- utilities[which(utilities$premise_address == house_emergency_2015$address &
                                                   utilities$service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_emergency_2015_relc)
summary(fit)
plot(utilities_emergency_2015_relc$charge_date, utilities_emergency_2015_relc$consumption)
abline(fit)
fit <- lm(charge_amount ~ charge_date, data = utilities_emergency_2015_relc)
summary(fit)
plot.new()
plot(utilities_emergency_2015_relc$charge_date, utilities_emergency_2015_relc$charge_amount)
abline(fit)

#Emergency Repairs, 2015, RGAS
utilities_emergency_2015_rgas <- utilities[which(utilities$premise_address == house_emergency_2015$address &
                                                   utilities$service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_emergency_2015_rgas)
summary(fit)
plot.new()
plot(utilities_emergency_2015_rgas$charge_date, utilities_emergency_2015_rgas$consumption)
abline(fit)
fit <- lm(charge_amount ~ charge_date, data = utilities_emergency_2015_rgas)
summary(fit)
plot.new()
plot(utilities_emergency_2015_rgas$charge_date, utilities_emergency_2015_rgas$charge_amount)
abline(fit)

#Emergency Repairs, 2014, RELC
house_emergency_2014 <- house_emergency[which(house_emergency$plan_year == 2014), ]
utilities_emergency_2014_relc <- utilities[which(utilities$premise_address == house_emergency_2014$address &
                                                   utilities$service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_emergency_2014_relc)
summary(fit)
plot(utilities_emergency_2014_relc$charge_date, utilities_emergency_2014_relc$consumption)
abline(fit)
fit <- lm(charge_amount ~ charge_date, data = utilities_emergency_2014_relc)
summary(fit)
plot.new()
plot(utilities_emergency_2014_relc$charge_date, utilities_emergency_2014_relc$charge_amount)
abline(fit)

#Emergency Repairs, 2014, RGAS
utilities_emergency_2014_rgas <- utilities[which(utilities$premise_address == house_emergency_2014$address &
                                                   utilities$service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_emergency_2014_rgas)
summary(fit)
plot(utilities_emergency_2014_rgas$charge_date, utilities_emergency_2014_rgas$consumption)
abline(fit)
fit <- lm(charge_amount ~ charge_date, data = utilities_emergency_2014_rgas)
summary(fit)
plot.new()
plot(utilities_emergency_2014_rgas$charge_date, utilities_emergency_2014_rgas$charge_amount)
abline(fit)

#Rental Rehabilitation, 2015, RELC
house_rental <- house[which(project == "Rental Rehabilitation"), ]
house_rental_2015 <- house_emergency[which(house_rental$plan_year == 2015), ]
utilities_rental_2015_relc <- utilities[which(utilities$premise_address == house_rental_2015$address &
                                                   utilities$service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_rental_2015_relc)
summary(fit)
plot.new()
plot(utilities_rental_2015_relc$charge_date, utilities_rental_2015_relc$consumption)
abline(fit)
fit <- lm(charge_amount ~ charge_date, data = utilities_rental_2015_relc)
summary(fit)
plot.new()
plot(utilities_rental_2015_relc$charge_date, utilities_rental_2015_relc$charge_amount)
abline(fit)

#Rental Rehabilitation, 2015, RGAS
utilities_rental_2015_rgas <- utilities[which(utilities$premise_address == house_rental_2015$address &
                                                utilities$service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_rental_2015_rgas)
summary(fit)
plot.new()
plot(utilities_rental_2015_rgas$charge_date, utilities_rental_2015_rgas$consumption)
abline(fit)
fit <- lm(charge_amount ~ charge_date, data = utilities_rental_2015_rgas)
summary(fit)
plot.new()
plot(utilities_rental_2015_rgas$charge_date, utilities_rental_2015_rgas$charge_amount)
abline(fit)

#Rental Rehabilitation, 2014, RELC
house_rental_2014 <- house_emergency[which(house_rental$plan_year == 2014), ]
utilities_rental_2014_relc <- utilities[which(utilities$premise_address == house_rental_2014$address &
                                                utilities$service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_rental_2014_relc)
summary(fit)
plot.new()
plot(utilities_rental_2014_relc$charge_date, utilities_rental_2014_relc$consumption)
abline(fit)
fit <- lm(charge_amount ~ charge_date, data = utilities_rental_2014_relc)
summary(fit)
plot.new()
plot(utilities_rental_2014_relc$charge_date, utilities_rental_2014_relc$charge_amount)
abline(fit)

#Rental Rehabilitation, 2014, RGAS
utilities_rental_2014_rgas <- utilities[which(utilities$premise_address == house_rental_2014$address &
                                                utilities$service_type == "RGAS"), ]
fit <- lm(consumption ~ charge_date, data = utilities_rental_2014_rgas)
summary(fit)
plot.new()
plot(utilities_rental_2014_rgas$charge_date, utilities_rental_2014_rgas$consumption)
abline(fit)
fit <- lm(charge_amount ~ charge_date, data = utilities_rental_2014_rgas)
summary(fit)
plot.new()
plot(utilities_rental_2014_rgas$charge_date, utilities_rental_2014_rgas$charge_amount)
abline(fit)

#t-tests
utilities_project <- utilities[which(utilities$premise_address == house$address), ]
utilities_nonproject <- utilities[which(utilities$premise_address != house$address), ]
t.test(utilities_project$consumption, utilities_nonproject$consumption)
t.test(utilities_project$charge_amount, utilities_nonproject$charge_amount)

house_open <- house[which(house$activity_status == "Open"), ]
house_completed <- house[which(house$activity_status == "Completed"), ]
utilities_project_open <- utilities[which(utilities$premise_address == house_open$address), ]
utilities_project_completed <- utilities[which(utilities$premise_address == house_completed$address), ]
t.test(utilities_project_open$consumption, utilities_project_completed$consumption)
t.test(utilities_projec_bw_t_open$charge_amount, utilities_project_completed$charge_amount)

house_home <- house[which(house$program == "HOME"), ]
house_cdbg <- house[which(house$program == "CDBG"), ]
utilities_project_home <- utilities[which(utilities$premise_address == house_home$address), ]
utilities_project_cdbg <- utilities[which(utilities$premise_address == house_cdbg$address), ]
t.test(utilities_project_home$consumption, utilities_project_cdbg$consumption)
t.test(utilities_project_home$charge_amount, utilities_project_cdbg$charge_amount)

#Discontinuity Analysis
install.packages("rddtools")
library(rddtools)
utilities_emergency_2015_relc$charge_date <- as.numeric(utilities_emergency_2015_relc$charge_date)
house_rdd_data <- rdd_data(y = utilities_emergency_2015_relc$consumption,
                           x = utilities_emergency_2015_relc$charge_date,
                           cutpoint = 17359)
bandwidthsize <- rdd_bw_ik(house_rdd_data)
fit <- rdd_reg_np(house_rdd_data, bandwidthsize)
summary(fit)

#Block Groups
junction$Tract <- as.character(junction$Tract)
junction$BlockGroup <- as.character(junction$BlockGroup)
junction$tract_block_group <- paste(junction$Tract, junction$BlockGroup, sep = "_")
junction_900_1 <- junction[which(junction$tract_block_group == "900_1"), ]
utilities_900_1 <- utilities[which(utilities$PremiseAddress == junction_900_1$Address), ]


