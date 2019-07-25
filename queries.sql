-- --List all tables
-- SELECT * FROM sys.tables
-- -- List all columns
-- SELECT * FROM sys.columns
-- -- List all tables and column names
-- select schema_name(tab.schema_id) as schema_name,
--     tab.name as table_name, 
--     col.column_id,
--     col.name as column_name, 
--     t.name as data_type,    
--     col.max_length,
--     col.precision
-- from sys.tables as tab
--     inner join sys.columns as col
--         on tab.object_id = col.object_id
--     left join sys.types as t
--     on col.user_type_id = t.user_type_id
-- order by schema_name,
--     table_name, 
--     column_id;
-- Get all bills for houses with HOME
-- SELECT a.Address, u.ServiceType, u.Consumption, u.ChargeAmount, u.DaysOfService, u.Year, u.Month, u.ChargeDate, u.AddressID into #TempTable
-- FROM Address as a, Utility as u, HousingProject as h
-- WHERE u.AddressID = a.AddressID and h.AddressID = a.AddressID
-- AND h.Program = 'HOME'
-- AND (u.ServiceType = 'RELC' OR u.ServiceType = 'RGAS')
-- ORDER BY u.PremiseAddress, u.Year, u.Month;

--Get all bills in general
-- SELECT a.Address, u.ServiceType, u.Consumption, u.ChargeAmount, u.DaysOfService, u.Year, u.Month, u.ChargeDate, u.AddressID into #TempTable
-- FROM Address as a, Utility as u
-- WHERE u.AddressID = a.AddressID
-- AND (u.ServiceType = 'RELC' OR u.ServiceType = 'RGAS')
-- ORDER BY u.PremiseAddress, u.Year, u.Month;

--Get all bills for houses with Emergency Repairs
SELECT a.Address, u.ServiceType, u.Consumption, u.ChargeAmount, u.DaysOfService, u.Year, u.Month, u.ChargeDate, u.AddressID, 
h.PlanYear, h.Project, h.Program, h.InitialDate, h.StatusDate into #TempTable
FROM Address as a, Utility as u, HousingProject as h
WHERE u.AddressID = a.AddressID and h.AddressID = a.AddressID
AND (h.Project = 'Emergency Repairs' OR h.Project = 'Homeowner Rehabilitation' OR h.Project = 'Rental Rehabilitation' OR h.Project='Energy Efficiency')
AND h.ActivityStatus = 'Completed'
AND (u.ServiceType = 'RELC' OR u.ServiceType = 'RGAS')
ORDER BY u.PremiseAddress, u.Year, u.Month;
--Get all bills for houses with no housing project
-- SELECT a.Address, u.ServiceType, u.Consumption, u.ChargeAmount, u.DaysOfService, u.Year, u.Month, u.ChargeDate, u.AddressID into #TempTable
-- FROM Address as a, Utility as u
-- WHERE u.AddressID = a.AddressID 
-- AND (u.ServiceType = 'RELC' OR u.ServiceType = 'RGAS')
-- AND a.AddressID NOT IN (SELECT AddressID from HousingProject)
-- ORDER BY u.PremiseAddress, u.Year, u.Month;

-- -- Collect these gas bills by month/year
--SELECT address, ServiceType, Month, Year, sum(Consumption) as Consumption, sum(ChargeAmount) as ChargeAmount
--FROM #TempTable
--GROUP BY address, ServiceType, Month, Year;

-- -- Get annual consumption for each house
--SELECT address, Year, sum(Consumption)
--FROM #TempTable
--GROUP BY address, Year;

-- get utilities bills from a specific type of housing project
SELECT t.*, t.Consumption/r.size as ConsumptionPerSQFT, r.size as Size
FROM RealEstate as r, #TempTable as t
WHERE r.AddressId = t.AddressId AND r.propClass = 'Single Family Residence / Townhouse'
AND r.size > 0;

DROP TABLE #TempTable;