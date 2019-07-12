library(tidyverse)

house <- read_csv("/Users/davidreynolds/Dropbox/CDS-2019-AlbanyHub/ToDatabase/TotalHouse_v03.csv")
utilities <- read_csv("/Users/davidreynolds/Dropbox/CDS-2019-AlbanyHub/ToDatabase/TotalUtilities.csv")
census <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/Tables/census.csv")
junction <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/ToDatabase/addr_junct_table.csv")

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
block_group_tract <- as.factor(block_group_tract)
total_pop <- as.numeric(total_pop)
total_inc <- as.numeric(total_inc)
inc_less_25k <- as.numeric(inc_less_25k)
inc_25k_49999 <- as.numeric(inc_25k_49999)
inc_50k_99999 <- as.numeric(inc_50k_99999)
inc_100k_more <- as.numeric(inc_100k_more)
total_labor <- as.numeric(total_labor)
total_in_laborforce <- as.numeric(total_in_laborforce)
in_laborforce_pct <- as.numeric(in_laborforce_pct)
total_notin_laborforce <-as.numeric(total_notin_laborforce)
notin_laborforce_pct <- as.numeric(notin_laborforce_pct)
total_civil_labor <- as.numeric(total_civil_labor)
emp_civil_labor <- as.numeric(emp_civil_labor)
emp_civil_labor_pct <- as.numeric(emp_civil_labor_pct)
unemp_civil_labor <- as.numeric(unemp_civil_labor)
unemp_civil_labor_pct <- as.numeric(unemp_civil_labor_pct)
total_armedforces <- as.numeric(total_armedforces)
total_vacdata <- as.numeric(total_vacdata)
total_occ_homes <- as.numeric(total_occ_homes)
occ_homes_pct <- as.numeric(occ_homes_pct)
total_vac_homes <- as.numeric(total_vac_homes)
vac_homes_pct <- as.numeric(vac_homes_pct)
total_ordata <- as.numeric(total_ordata)
total_owner <- as.numeric(total_owner)
owner_pct <- as.numeric(owner_pct)
total_renter <- as.numeric(total_renter)
renter_pct <- as.numeric(renter_pct)

View(house)
View(utilities)
View(census)

#house
attach(house)

fit <- lm(funded_amount ~ plan_year + project + program)
summary(fit)

fit <- lm(funded_amount ~ plan_year)
summary(fit)

fit <- lm(funded_amount ~ project)
summary(fit)

fit <- lm(funded_amount ~ program)
summary(fit)

anova <- aov(funded_amount ~ plan_year + project + program)
summary(anova)

anova <- aov(funded_amount ~ plan_year)
summary(anova)

anova <- aov(funded_amount ~ project)
summary(anova)

anova <- aov(funded_amount ~ program)
summary(anova)

#utlities
attach(utilities)
fit <- lm(charge_amount ~ service_type + consumption + days_of_service + year)
summary(fit)

fit <- lm(charge_amount ~ service_type)
summary(fit)

fit <- lm(charge_amount ~ consumption)
summary(fit)

fit <- lm(charge_amount ~ days_of_service)
summary(fit)

fit <- lm(charge_amount ~ year)
summary(fit)

fit <- lm(consumption ~ service_type + days_of_service + charge_amount + year)
summary(fit)

fit <- lm(consumption ~ service_type)
summary(fit)

fit <- lm(consumption ~ days_of_service)
summary(fit)

fit <- lm(consumption ~ charge_amount)
summary(fit)

fit <- lm(consumption ~ year)
summary(fit)

anova <- aov(charge_amount ~ service_type + consumption + days_of_service + year)
summary(anova)

anova <- aov(charge_amount ~ service_type)
summary(anova)

anova <- aov(charge_amount ~ consumption)
summary(anova)

anova <- aov(charge_amount ~ days_of_service)
summary(anova)

anova <- aov(charge_amount ~ year)
summary(anova)

anova <- aov(consumption ~ service_type + days_of_service + charge_amount + year)
summary(anova)

anova <- aov(consumption ~ service_type)
summary(anova)

anova <- aov(consumption ~ days_of_service)
summary(anova)

anova <- aov(consumption ~ charge_amount)
summary(anova)

anova <- aov(consumption ~ year)
summary(anova)

#census
attach(census)

fit <- lm(in_laborforce_pct ~., data = census)
summary(fit)

anova <- aov(emp_civil_labor_pct ~ block_group_tract)
summary(anova)

#Testing Individual Projects
house_emergency <- house[which(project == "Emergency Repairs"), ]
View(house_emergency)
house_homeowner <- house[which(project == "Homeowner Rehabilitation"), ]
View(house_homeowner)

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

utilities_10 <- utilities[which(premise_address == "624 JEFFERIES AVE" & service_type == "RELC"), ]
fit <- lm(consumption ~ charge_date, data = utilities_10)
summary(fit)
plot(utilities_10$charge_date, utilities_10$consumption)
abline(fit)

house_emergency_2015 <- house_emergency[which(house_emergency$plan_year == 2015), ]
utilities_emergency_2015 <- utilities[which(utilities$premise_address == house_emergency_2015$address), ]
utilities_emergency_2015 <- na.omit(utilities_emergency_2015)
fit <- lm(consumption ~ charge_date, data = utilities_emergency_2015)
summary(fit)
plot(utilities_emergency_2015$charge_date, utilities_emergency_2015$consumption)
abline(fit)
fit <- lm(charge_amount ~ charge_date, data = utilities_emergency_2015)
summary(fit)
plot.new()
plot(utilities_emergency_2015$charge_date, utilities_emergency_2015$consumption)
abline(fit)

utilities_not_emergency_2015 <- utilities[which(utilities$premise_address != house_emergency_2015), ]
View(utilities_not_emergency_2015)

