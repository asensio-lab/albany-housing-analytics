SELECT *
FROM housing_projects as h, utilities as u, addresses as a
WHERE h.PrimaryID = u.PrimaryID AND h.PrimaryID = a.Id AND u.ServiceType LIKE 'RWTR'
-- Generated utilities_housing_joined_elec.csv
-- Gets all the residential electricity bill records for housing project