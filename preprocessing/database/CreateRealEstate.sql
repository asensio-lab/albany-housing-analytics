CREATE TABLE [dbo].[RealEstate](
    [RealEstateID] [int] NOT NULL,
	[Address] [varchar](255) NOT NULL,
	[LotSize] [float] NULL,
	[ZoningType] [varchar](255) NULL,
	[SiteZoningIdent] [varchar](255) NULL,
	[PropClass] [varchar](255) NULL,
	[YearBuilt] [int] NULL,
	[Size] [float] NULL,
	[Baths] [float] NULL,
	[Beds] [float] NULL,
	[Rooms] [float] NULL,
	[Floors] [varchar](255) NULL,
	[Condition] [varchar](255) NULL,
	[FoundationType] [varchar](255) NULL,
	[RoofCover] [varchar](255) NULL,
	[WallType] [varchar](255) NULL,
	[ImprovementYear] [int] NULL,
	[Assessment] [float] NULL,
	[Market] [float] NULL,
	[AddressId] [int] NULL,
CONSTRAINT [PK_RealEstate] PRIMARY KEY CLUSTERED
(
    [RealEstateID] asc
)
) ON [PRIMARY]
GO