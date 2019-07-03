SELECT COUNT( DISTINCT PrimaryID) as address_count, AVG(Consumption) as mean_kwh, AVG(ChargeAmount) as mean_charge
FROM (
    SELECT u.PrimaryID,u.Consumption, u.ChargeAmount, r.size
    FROM real_estate as r, utilities as u
    WHERE u.PrimaryID = r.primaryId and u.ServiceType LIKE 'RGAS' 
    and r.size IS NOT NULL
    AND r.propClass = 'Single Family Residence / Townhouse'
) AS t
-- gets average consumption per month over all properties(residential)
-- Not Normalized by by square footage
-- ONLY for addresses classified as  'Single Family Residence / Townhouse'