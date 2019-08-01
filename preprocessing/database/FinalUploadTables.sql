BULK INSERT Address
FROM 'Address_v02.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');
GO

BULK INSERT AddressJunctBG
FROM 'AddrJunctBG_v02.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');
GO

BULK INSERT BGJunctTract
FROM 'BGJunctTract_v02.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');
GO

BULK INSERT BlockGroup
FROM 'BlockGroup_v03.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');
GO

BULK INSERT HousingProject
FROM 'Project_v02.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');
GO

BULK INSERT Tax
FROM 'Tax_v03.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');
GO

BULK INSERT Tract
FROM 'Tract_v04.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');
GO

BULK INSERT Utility
FROM 'utilities.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');
GO

BULK INSERT Weather
FROM 'Weather_v03.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');
GO