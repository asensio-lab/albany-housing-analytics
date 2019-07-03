SELECT a.Address, h.Project, h.Plan_Year, u.*, r.size, r.assessment, r.propClass
FROM utilities as u, addresses as a, housing_projects as h LEFT JOIN real_estate as r ON h.PrimaryID = r.PrimaryId
WHERE a.Id =u.PrimaryID and a.Id = h.PrimaryID  AND u.ServiceType LIKE 'RELC'