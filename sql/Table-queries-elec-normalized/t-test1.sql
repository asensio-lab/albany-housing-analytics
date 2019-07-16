SELECT u.Consumption/r.size as ConsumptionPerSqFt
FROM real_estate as r, utilities as u, housing_projects as h
WHERE u.PrimaryID = r.primaryId and h.primaryId = u.PrimaryID and u.ServiceType LIKE 'RELC' 
and r.size IS NOT NULL
AND r.propClass = 'Single Family Residence / Townhouse';

SELECT u.Consumption/r.size as ConsumptionPerSqFt
FROM real_estate as r, utilities as u
WHERE u.PrimaryID = r.primaryId and u.ServiceType LIKE 'RELC' 
and r.size IS NOT NULL
AND r.propClass = 'Single Family Residence / Townhouse';