SELECT a.Tract, a.BlockGroup, COUNT(DISTINCT u.PrimaryId) as address_count
FROM utilities as u, addresses as a, housing_projects as h 
WHERE a.Id = u.PrimaryId AND h.PrimaryID = u.PrimaryID AND u.ServiceType LIKE 'RWTR'
GROUP BY a.Tract, a.BlockGroup