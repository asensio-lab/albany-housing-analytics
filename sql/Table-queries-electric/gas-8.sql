SELECT COUNT(u.Consumption) as mean_ccf
FROM utilities as u
WHERE u.ServiceType LIKE 'RGAS';
-- gets average consumption per month over all properties(residential)