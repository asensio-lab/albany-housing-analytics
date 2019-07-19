
-- -- Get all bills for houses with housing projects
-- -- SELECT a.address, u.* INTO #TempTable
-- -- FROM housing_projects as h, addresses as a, utilities as u
-- -- WHERE h.PrimaryID = u.PrimaryID AND h.PrimaryID = a.Id
-- -- AND h.project = 'Emergency Repairs'
-- -- AND (h.Plan_Year = 2014 or h.Plan_Year = 2015);

-- --Get all bills in general

SELECT a.address, u.ServiceType, u.Consumption, u.DaysOfService, u.Year, u.Month, u.ChargeDate, u.PrimaryID
FROM addresses as a, utilities as u, housing_projects as h
WHERE u.PrimaryID = a.Id and a.ID = h.PrimaryID and h.project = 'Energy Efficiency'
AND (u.ServiceType = 'RELC' OR u.ServiceType = 'RGAS');
ORDER BY u.PremiseAddress, u.Year, u.Month
-- -- Collect these gas bills by month/year
-- --SELECT address, ServiceType, Month, Year, sum(Consumption) as Consumption, sum(ChargeAmount) as ChargeAmount
-- --FROM #TempTable
-- --GROUP BY address, ServiceType, Month, Year;

-- -- Get annual consumption for each house
-- --SELECT address, Year, sum(Consumption)
-- --FROM #TempTable
-- --GROUP BY address, Year;

-- -- get utilities bills from a specific type of housing project
-- SELECT t.*, t.Consumption/r.size as ConsumptionPerSQFT
-- FROM real_estate as r, #TempTable as t
-- WHERE r.primaryId = t.primaryId AND r.propClass = 'Single Family Residence / Townhouse'
-- AND r.size > 0

-- DROP TABLE #TempTable