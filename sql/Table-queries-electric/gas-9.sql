-- SELECT a.Tract, a.BlockGroup, COUNT(DISTINCT h.PrimaryId) as address_count, AVG(u.ServiceRate) as mean_ccf
-- FROM utilities as u, addresses as a, housing_projects as h
-- WHERE a.Id = u.PrimaryId AND u.PrimaryId = h.PrimaryId AND u.ServiceType LIKE 'RGAS' AND u.ServiceRate <> ''
-- GROUP BY a.Tract, a.BlockGroup

SELECT a.Tract, a.BlockGroup, AVG(IFNULL(u.ServiceRate, 0)) as mean_rate
FROM utilities as u, addresses as a, housing_projects as h
WHERE a.Id = u.PrimaryId AND u.PrimaryId = h.PrimaryID AND u.ServiceType LIKE 'RGAS' 
GROUP BY a.Tract, a.BlockGroup;

-- select top 3 *
-- from utilities