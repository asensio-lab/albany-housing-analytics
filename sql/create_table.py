import mysql.connector
import pandas as pd
mydb = mysql.connector.connect(
  host="localhost",
  user="guest",
  passwd="password.0",
  database="albanyhub"
)
mycursor = mydb.cursor()
mycursor.execute("DROP TABLE IF EXISTS housing_projects")
mycursor.execute('''
CREATE TABLE housing_projects 
(id INT AUTO_INCREMENT PRIMARY KEY, address VARCHAR(255), plan_year INT, \
idis_project INT, project VARCHAR(255), idis_activity_id INT,
activity_status VARCHAR(255), program VARCHAR(255), funded_amount FLOAT, 
draw_amount FLOAT, balance FLOAT);''')
print("Created table 'housing_projects'")

cdbg = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/Processed-Data/CDBG_2007-2017_fixed_address.csv')
cdbg = cdbg.drop([cdbg.columns[0],'City', 'State', 'XY Coordinates', 'Parcel ID'], axis=1)
cdbg_list = list(cdbg.where((pd.notnull(cdbg)), None).itertuples(index=False, name=None))

home = pd.read_csv('~/Dropbox/CDS-2019-AlbanyHub/Processed-Data/HOME_2007-2017_fixed_address.csv')
home = home.drop([home.columns[0],'City', 'State', 'XY Coordinates', 'Parcel ID'], axis=1)
home_list = list(home.where((pd.notnull(home)), None).itertuples(index=False, name=None))

#print(cdbg_list[48])
sql = '''INSERT INTO housing_projects (id, address, plan_year,
idis_project, project, idis_activity_id,
activity_status, program, funded_amount, 
draw_amount, balance) VALUES (default, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);'''
mycursor.executemany(sql, cdbg_list)

print(mycursor.rowcount, "was inserted")

mycursor.executemany(sql, home_list)
print(mycursor.rowcount, "was inserted")

mydb.commit()