BULK INSERT HousingProject
FROM 'Project_v02.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');