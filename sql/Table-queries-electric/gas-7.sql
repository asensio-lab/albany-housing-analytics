SELECT a.Tract, a.BlockGroup, COUNT(DISTINCT u.PrimaryId) as address_count
FROM utilities as u, addresses as a, housing_projects as h 
WHERE a.Id = u.PrimaryId AND u.PrimaryID = h.PrimaryID AND u.ServiceType LIKE 'RGAS'
GROUP BY a.Tract, a.BlockGroup
-- generated address_count_per_blockgroup.csv
-- Gets the count of addresses in the utilities which have data for residential electricity,
-- Per block group