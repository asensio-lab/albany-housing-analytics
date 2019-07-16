SELECT AVG(u.Consumption) as mean_swr, AVG(u.ChargeAmount) as mean_charge
FROM utilities as u
WHERE u.ServiceType LIKE 'RSWR';
-- gets average consumption per month over all properties(residential)