IF OBJECT_ID('dbo.addresses') IS NOT NULL
DROP TABLE dbo.addresses
GO

CREATE TABLE dbo.addresses(
    Id INT NOT NULL PRIMARY KEY, -- primary key column
    Address [NVARCHAR](255) NOT NULL,
    Xcoord FLOAT NOT NULL,
    Ycoord FLOAT NOT NULL,
    Tract [NVARCHAR](8) NOT NULL,
    BlockGroup [NVARCHAR](8) NOT NULL
);
GO

BULK 
INSERT dbo.addresses
FROM '/home/mirabel/Documents/cds/sql/addr1_10000_db.csv'
WITH(
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
)
GO