CREATE TABLE [dbo].[utilities](
	[ChargeID] [bigint] NOT NULL,
	[Premise] [varchar](255) NULL,
	[PremiseAddress] [varchar](255) NULL,
	[Customer] [int] NULL,
	[ServiceType] [varchar](255) NULL,
	[ServiceNumber] [int] NULL,
	[ServiceRate] [varchar](255) NULL,
	[Consumption] [float] NULL,
	[DaysOfService] [int] NULL,
	[UnitOfMeasure] [varchar](255) NULL,
	[ChargeAmount] [float] NULL,
	[ChargeDate] [varchar](255) NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[Day] [int] NULL,
	[AddressID] [int] NOT NULL, 
    [YearMonth] [varchar](255) NULL,
    [WeatherID] [int] NULL,
    CONSTRAINT [PK_Utility] PRIMARY KEY CLUSTERED
    (
        [ChargeID] asc
    )
) ON [PRIMARY]
GO
