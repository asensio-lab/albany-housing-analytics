library(tidyverse)

proj <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/subsets of utilities/repairs_utlities_sqft_2014.csv")
nonproj <- read_csv("/Users/davidreynolds/Dropbox (GaTech)/CDS-2019-AlbanyHub/subsets of utilities/utilities_nonproj_subsample")
proj <- na.omit(proj)
nonproj <- na.omit(nonproj)
proj$ConsumptionPerSQFT <- as.numeric(proj$ConsumptionPerSQFT)
nonproj$ConsumptionPerSQFT <- as.numeric(nonproj$ConsumptionPerSQFT)

#Electric
proj_relc <- proj[which(proj$ServiceType == "RELC"), ]
nonproj_relc <- nonproj[which(nonproj$ServiceType == "RELC"), ]
fit <- lm(proj_relc$ConsumptionPerSQFT ~ proj_relc$ChargeDate, data = proj_relc)
summary(fit)
plot(proj_relc$ChargeDate, proj_relc$ConsumptionPerSQFT)
abline(fit)

proj_relc_before <- proj_relc[which(proj_relc$Year == "2012" | proj_relc$Year == "2013"), ]
proj_relc_after <- proj_relc[which(proj_relc$Year == "2015" | proj_relc$Year == "2016"), ]
nonproj_relc_before <- nonproj_relc[which(nonproj_relc$Year == "2012" | nonproj_relc$Year == "2013"), ]
nonproj_relc_after <- nonproj_relc[which(nonproj_relc$Year == "2015" | nonproj_relc$Year == "2016"), ]

proj_relc_before <- proj_relc_before %>%
  select(Address, ConsumptionPerSQFT, ChargeAmount) %>%
  group_by(Address) %>%
  summarize_each(list(sum))

proj_relc_after <- proj_relc_after %>%
  select(Address, ConsumptionPerSQFT, ChargeAmount) %>%
  group_by(Address) %>%
  summarize_each(list(sum))

nonproj_relc_before <- nonproj_relc_before %>%
  select(Address, ConsumptionPerSQFT, ChargeAmount) %>%
  group_by(Address) %>%
  summarize_each(list(sum))

nonproj_relc_after <- nonproj_relc_after %>%
  select(Address, ConsumptionPerSQFT, ChargeAmount) %>%
  group_by(Address) %>%
  summarize_each(list(sum))

proj_relc_before <- rename(proj_relc_before, consumption_before = ConsumptionPerSQFT)
proj_relc_before <- rename(proj_relc_before, charge_before = ChargeAmount)
proj_relc_after <- rename(proj_relc_after, consumption_after = ConsumptionPerSQFT)
proj_relc_after <- rename(proj_relc_after, charge_after = ChargeAmount)
nonproj_relc_before <- rename(nonproj_relc_before, consumption_before = ConsumptionPerSQFT)
nonproj_relc_before <- rename(nonproj_relc_before, charge_before = ChargeAmount)
nonproj_relc_after <- rename(nonproj_relc_after, consumption_after = ConsumptionPerSQFT)
nonproj_relc_after <- rename(nonproj_relc_after, charge_after = ChargeAmount)

proj_relc <- merge(proj_relc_before, proj_relc_after, by = "Address")
nonproj_relc <- merge(nonproj_relc_before, nonproj_relc_after, by = "Address")

proj_relc$consumption_difference <- proj_relc$consumption_before - proj_relc$consumption_after
proj_relc$charge_difference <- proj_relc$charge_before - proj_relc$charge_after
nonproj_relc$consumption_difference <- nonproj_relc$consumption_before - nonproj_relc$consumption_after
nonproj_relc$charge_difference <- nonproj_relc$charge_before - nonproj_relc$charge_after

t.test(proj_relc$consumption_before, proj_relc$consumption_after)
t.test(proj_relc$charge_before, proj_relc$charge_after)
t.test(proj_relc$consumption_difference, nonproj_relc$consumption_difference)
t.test(proj_relc$charge_difference, nonproj_relc$charge_difference)

#Gas
proj_rgas <- proj[which(proj$ServiceType == "RGAS"), ]
nonproj_rgas <- nonproj[which(nonproj$ServiceType == "RGAS"), ]
fit <- lm(proj_rgas$ConsumptionPerSQFT ~ proj_rgas$ChargeDate, data = proj_rgas)
summary(fit)
plot(proj_rgas$ChargeDate, proj_rgas$ConsumptionPerSQFT)
abline(fit)

proj_rgas_before <- proj_rgas[which(proj_rgas$Year == "2012" | proj_rgas$Year == "2013"), ]
proj_rgas_after <- proj_rgas[which(proj_rgas$Year == "2015" | proj_rgas$Year == "2016"), ]
nonproj_rgas_before <- nonproj_rgas[which(nonproj_rgas$Year == "2012" | nonproj_rgas$Year == "2013"), ]
nonproj_rgas_after <- nonproj_rgas[which(nonproj_rgas$Year == "2015" | nonproj_rgas$Year == "2016"), ]

proj_rgas_before <- proj_rgas_before %>%
  select(Address, ConsumptionPerSQFT, ChargeAmount) %>%
  group_by(Address) %>%
  summarize_each(list(sum))

proj_rgas_after <- proj_rgas_after %>%
  select(Address, ConsumptionPerSQFT, ChargeAmount) %>%
  group_by(Address) %>%
  summarize_each(list(sum))

nonproj_rgas_before <- nonproj_rgas_before %>%
  select(Address, ConsumptionPerSQFT, ChargeAmount) %>%
  group_by(Address) %>%
  summarize_each(list(sum))

nonproj_rgas_after <- nonproj_rgas_after %>%
  select(Address, ConsumptionPerSQFT, ChargeAmount) %>%
  group_by(Address) %>%
  summarize_each(list(sum))

proj_rgas_before <- rename(proj_rgas_before, consumption_before = ConsumptionPerSQFT)
proj_rgas_before <- rename(proj_rgas_before, charge_before = ChargeAmount)
proj_rgas_after <- rename(proj_rgas_after, consumption_after = ConsumptionPerSQFT)
proj_rgas_after <- rename(proj_rgas_after, charge_after = ChargeAmount)
nonproj_rgas_before <- rename(nonproj_rgas_before, consumption_before = ConsumptionPerSQFT)
nonproj_rgas_before <- rename(nonproj_rgas_before, charge_before = ChargeAmount)
nonproj_rgas_after <- rename(nonproj_rgas_after, consumption_after = ConsumptionPerSQFT)
nonproj_rgas_after <- rename(nonproj_rgas_after, charge_after = ChargeAmount)

proj_rgas <- merge(proj_rgas_before, proj_rgas_after, by = "Address")
nonproj_rgas <- merge(nonproj_rgas_before, nonproj_rgas_after, by = "Address")

proj_rgas$consumption_difference <- proj_rgas$consumption_before - proj_rgas$consumption_after
proj_rgas$charge_difference <- proj_rgas$charge_before - proj_rgas$charge_after
nonproj_rgas$consumption_difference <- nonproj_rgas$consumption_before - nonproj_rgas$consumption_after
nonproj_rgas$charge_difference <- nonproj_rgas$charge_before - nonproj_rgas$charge_after

t.test(proj_rgas$consumption_before, proj_rgas$consumption_after)
t.test(proj_rgas$charge_before, proj_rgas$charge_after)
t.test(proj_rgas$consumption_difference, nonproj_rgas$consumption_difference)
t.test(proj_rgas$charge_difference, nonproj_rgas$charge_difference)
