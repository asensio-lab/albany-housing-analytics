CREATE TABLE [dbo].[Address](
	[AddressID] [int] NOT NULL,
    [Address] [varchar](255) NOT NULL,
	[XCoord] [float] NULL,
	[YCoord] [float] NULL,
	[Tract] [int] NULL,
	[BlockGroup] [int] NULL,
	[Block] [int] NULL,
	[TaxID] [int] NOT NULL,
	[BlockGroupTract] [varchar](255) NULL,
	[BlockGroupID] [int] NOT NULL,
	[TractID] [int] NOT NULL,
	[RealEstateID] [int] NOT NULL,
CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED
(
    [AddressID] ASC
)
) ON [PRIMARY]
GO