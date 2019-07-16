SELECT AVG(u.Consumption) as mean_swr, AVG(u.ChargeAmount) as mean_charge
FROM utilities as u, addresses as a, housing_projects as h
WHERE a.Id = u.PrimaryId AND u.PrimaryId = h.PrimaryId AND u.ServiceType LIKE 'RSWR'
-- gets average consumption per month over all housing projects (Residential)