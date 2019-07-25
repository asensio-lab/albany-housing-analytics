ALTER TABLE Address 
    DROP CONSTRAINT FK_Address_Tax
GO

DROP TABLE dbo.Tax
GO

CREATE TABLE [dbo].[Tax](
	[TaxID] [int] NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[ZoneCode] [varchar](255) NULL,
	[ParcelNo] [varchar](255) NULL,
	[PrevVal] [float] NULL,
	[CurrVal] [float] NULL,
	[ValChgDate] [varchar](255) NULL,
	[PropClass] [varchar](255) NULL,
	[TotalAcres] [float] NULL,
	[Year] [int] NULL,
	[TSDates] [varchar](255) NULL,
    [TSYear] [int] NULL,
    [TSMonth] [int] NULL,
    [TSDay] [int] NULL,
 CONSTRAINT [PK_Tax] PRIMARY KEY CLUSTERED 
(
	[TaxId] ASC
)
) ON [PRIMARY]
GO

BULK INSERT Tax
FROM 'Tax_v03.csv'
WITH (DATA_SOURCE = 'databasestore',
    FIRSTROW=2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    FORMAT = 'CSV');

ALTER TABLE dbo.Address
   ADD CONSTRAINT FK_Address_Tax FOREIGN KEY (TaxID)
      REFERENCES dbo.Tax (TaxID)
      ON DELETE CASCADE
      ON UPDATE CASCADE
GO


