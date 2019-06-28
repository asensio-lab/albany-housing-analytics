SELECT a.Tract, a.BlockGroup, AVG(u.Consumption) as avg_swr, AVG(u.ChargeAmount) as avg_charge, COUNT(u.consumption) as numrecords
FROM utilities as u, addresses as a
WHERE a.Id = u.PrimaryId AND u.ServiceType LIKE 'RSWR'
GROUP BY a.Tract, a.BlockGroup
-- generated avg_kwh_per_blockgroup.csv
-- Gets the average consumption in the utilities which have data for residential electricity,
-- Per block group