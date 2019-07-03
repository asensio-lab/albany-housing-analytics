SELECT COUNT(DISTINCT PrimaryID) as address_count, AVG(Consumption) as mean_kwh, AVG(ChargeAmount) as mean_charge
FROM (
    SELECT u.PrimaryID, r.size, u.ChargeAmount, u.Consumption
    FROM real_estate as r, utilities as u
    WHERE u.PrimaryID = r.primaryId and u.ServiceType LIKE 'RELC' 
    and r.size IS NOT NULL
    AND r.propClass = 'Single Family Residence / Townhouse'
) AS t
-- gets average consumption per month over all properties(residential)
-- Not Normalized by Square Footage
-- ONLY for addresses classified as  'Single Family Residence / Townhouse'