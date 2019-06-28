SELECT COUNT(u.Consumption) as mean_kwh
FROM utilities as u
WHERE u.ServiceType LIKE 'RELC';
-- gets average consumption per month over all properties(residential)