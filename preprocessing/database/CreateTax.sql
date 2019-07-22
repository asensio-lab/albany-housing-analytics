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
    [TSYear] [float] NULL,
    [TSMonth] [float] NULL,
    [TSDay] [float] NULL,
 CONSTRAINT [PK_Tax] PRIMARY KEY CLUSTERED 
(
	[TaxId] ASC
)
) ON [PRIMARY]
GO