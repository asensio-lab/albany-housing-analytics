SELECT u.Year, u.Month, a.Address, u.Consumption, w.HTDD, w.CLDD, w.MeanTemp, r.size, h.Plan_Year
FROM utilities as u, addresses as a, housing_projects as h, weather_month as w, real_estate as r
WHERE u.Year = w.Year and u.Month = w.Month and a.Id = u.PrimaryID and h.primaryId = u.PrimaryID and r.PrimaryId = a.Id
AND u.ServiceType = 'RGAS' AND h.Project = 'Emergency Repairs'