import pyodbc as p 
import csv
#see installation instructions for pyodbc
FILE = '/home/mirabel/Documents/cds/sql/addr1_10000_db.csv'
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
cursor.execute('''IF OBJECT_ID('dbo.addresses') IS NOT NULL
DROP TABLE dbo.addresses''')
#### Create
cursor.execute('''CREATE TABLE dbo.addresses(
    Id INT NOT NULL PRIMARY KEY, -- primary key column
    Address [NVARCHAR](255) NOT NULL,
    Xcoord FLOAT NOT NULL,
    Ycoord FLOAT NOT NULL,
    Tract [NVARCHAR](8) NOT NULL,
    BlockGroup [NVARCHAR](8) NOT NULL
);
''')
count = 0
with open(FILE, newline='') as f:
    reader = csv.reader(f)
    next(reader)
    for row in reader:
        row = [int(row[0]), row[1], float(row[2]), float(row[3]), str(row[4]), str(row[5])]
        sql = '''INSERT INTO dbo.addresses (Id, Address, Xcoord, Ycoord, Tract, BlockGroup)
        VALUES (?, ?, ?, ?, ?, ?);'''
        cursor.execute(sql, row)
        count = count+1
        if count % 100 == 0:
            print(str(count), 'inserted')
cnxn.commit()
    