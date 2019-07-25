CREATE TABLE [dbo].[AddressJunctBG](
	[AddressID] [int] NOT NULL,
    [BlockGroupID] [int] NOT NULL,
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[BGJunctTract](
	[BlockGroupID] [int] NOT NULL,
    [TractID] [int] NOT NULL,
) ON [PRIMARY]
GO

BULK INSERT AddressJunctBG
FROM 'AddrJunctBG_v02.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV')
GO

BULK INSERT BGJunctTract
FROM 'BGJunctTract_v02.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV')
GO