SELECT COUNT( DISTINCT PrimaryID) as address_count, AVG(ConsumptionPerSQFT) as mean_kwh_persqft, AVG(ChargeAmountPerSQFT) as mean_charge_persqft
FROM (
    SELECT u.PrimaryID, u.Consumption/r.size as ConsumptionPerSQFT, u.ChargeAmount/r.size as ChargeAmountPerSQFT, r.size, u.ServiceType, u.UnitOfMeasure, u.Month, u.Year
    FROM real_estate as r, utilities as u
    WHERE u.PrimaryID = r.primaryId and u.ServiceType LIKE 'RSWR' 
    and r.size IS NOT NULL
) AS t
-- gets average consumption per month over all properties(residential)
-- Normalized by by square footage