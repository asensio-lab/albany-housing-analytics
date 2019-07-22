CREATE TABLE [dbo].[Weather] (
    [WeatherID] [int] NOT NULL,
    [Year] [float] NOT NULL,
    [Month] [float] NOT NULL,
    [Date] [varchar](255) NULL,
    [MonthlyMaxTemp] [float] NOT NULL,
    [MonthlyMinTemp] [float] NOT NULL,
    [MonthlyMeanTemp] [float] NOT NULL,
    [AWND] [float] NULL,
    [CLDD] [float] NOT NULL,
    [HTDD] [float] NOT NULL,
    [YearMonth] [varchar](255) NOT NULL
CONSTRAINT [PK_Weather] PRIMARY KEY CLUSTERED
(
    [WeatherID] asc
)
) ON [PRIMARY]
GO