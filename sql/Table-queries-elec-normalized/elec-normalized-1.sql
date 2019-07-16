SELECT a.Tract, a.BlockGroup, COUNT(DISTINCT t.PrimaryId) as address_count, AVG(t.ConsumptionPerSQFT) as mean_kwh_persqft, AVG(t.ChargeAmountPerSQFT) as mean_charge_persqft
FROM(
    SELECT u.PrimaryID, u.Consumption/r.size as ConsumptionPerSQFT, u.ChargeAmount/r.size as ChargeAmountPerSQFT, r.size, u.ServiceType, u.UnitOfMeasure, u.Month, u.Year
    FROM real_estate as r, utilities as u, housing_projects as h
    WHERE u.PrimaryID = r.primaryId and h.primaryId = u.PrimaryID and u.ServiceType LIKE 'RELC' 
    and r.size IS NOT NULL 
) AS t, addresses as a
WHERE a.Id = t.PrimaryID
GROUP BY a.Tract, a.BlockGroup
--- Generated avgkwh_proj_persqft.csv
--- Gets the average consumption in kwh and average charge amount
--- For each utility RELC bill for houses which received housing projects
--- Normalized by the square footage of the house
--- Per tract/block group