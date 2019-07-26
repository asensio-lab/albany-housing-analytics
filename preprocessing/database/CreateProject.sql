CREATE TABLE [dbo].[HousingProject](
	[ProjectID] [int] NOT NULL,
    [AddressID] [int] NOT NULL,
	[ParcelID] [varchar](255) NULL,
	[Address] [varchar](255) NOT NULL,
	[PlanYear] [int] NOT NULL,
	[IDISProject] [int] NOT NULL,
	[Project] [varchar](255) NOT NULL,
	[IDISActivityID] [int] NOT NULL,
	[ActivityStatus] [varchar](255) NOT NULL,
	[Program] [varchar](255) NOT NULL,
	[FundedAmount] [float] NOT NULL,
	[DrawAmount] [float] NULL,
	[Balance] [float] NULL,
	[MultihomeType] [varchar](255) NULL,
	[Multihome] [varchar](255) NULL,
	[IDISActivityIDFull] [float] NOT NULL,
	[IDISActivityIDFirst] [int] NOT NULL,
	[IDISActivityIDEnd] [float] NOT NULL,
	[InitialDate] [varchar](255) NULL,
	[StatusDate] [varchar](255) NULL,
CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED
(
    [ProjectID] ASC
)
) ON [PRIMARY]
GO