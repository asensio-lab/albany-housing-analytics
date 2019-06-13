import mysql.connector;

mydb = mysql.connector.connect(
  host="localhost",
  user="guest",
  passwd="password.0"
)
print(mydb)

mycursor = mydb.cursor()

mycursor.execute("CREATE DATABASE albanyhub")

mycursor.execute("SHOW DATABASES")

for x in mycursor:
    print(x)