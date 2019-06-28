SELECT COUNT(DISTINCT h.ProjID)
FROM housing_projects as h, utilities as u 
WHERE h.PrimaryID = u.PrimaryID AND u.ServiceType LIKE 'RELC'