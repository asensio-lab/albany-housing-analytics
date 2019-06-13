import mysql.connector
import pandas as pd

mydb = mysql.connector.connect(
  host="localhost",
  user="guest",
  passwd="password.0",
  database="albanyhub"
)
mycursor = mydb.cursor()

mycursor.execute('''SELECT address, project, program
FROM housing_projects
WHERE funded_amount=0''')
for a in mycursor.fetchall():
    print(a)