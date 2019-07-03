import pyodbc as p 
import csv
#see installation instructions for pyodbc
FILE = '/home/mirabel/Documents/cds/TotalUtilities_fordb.csv'
server='albanyhub-cds-2019.database.windows.net'
database = 'AlbanyHub'
username = 'test'
password = 'cds-2019-pass'
cnxn = p.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
#Sample select query
cursor.execute("SELECT @@version;") 
row = cursor.fetchone() 
while row: 
    print(row[0])
    row = cursor.fetchone()

#### Drop if exists
cursor.execute('''IF OBJECT_ID('dbo.utilities') IS NOT NULL
DROP TABLE dbo.utilities''')
#### Create
cursor.execute('''CREATE TABLE dbo.census_tract(
    Id INT NOT NULL PRIMARY KEY, -- primary key column
    Address [NVARCHAR](255) NOT NULL,
    Xcoord FLOAT NOT NULL,
    Ycoord FLOAT NOT NULL,
    Tract [NVARCHAR](8) NOT NULL,
    BlockGroup [NVARCHAR](8) NOT NULL
);
''')