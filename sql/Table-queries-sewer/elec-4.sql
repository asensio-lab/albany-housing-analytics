SELECT a.Tract, a.BlockGroup, COUNT(DISTINCT h.PrimaryId) as address_count, AVG(u.Consumption) as mean_swr, AVG(u.ChargeAmount) as mean_charge
FROM utilities as u, addresses as a, housing_projects as h
WHERE a.Id = u.PrimaryId AND u.PrimaryId = h.PrimaryId AND u.ServiceType LIKE 'RSWR'
GROUP BY a.Tract, a.BlockGroup
-- generated avgkwh_blockgroup_elec.csv
-- Gets average consumption over all housing projects per 