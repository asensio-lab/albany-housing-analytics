import mysql.connector
import pandas as pd
mydb = mysql.connector.connect(
  host="localhost",
  user="guest",
  passwd="password.0",
  database="albanyhub"
)
mycursor = mydb.cursor()

mycursor.execute('''DROP TABLE IF EXISTS utilities''')
mycursor.execute('''CREATE TABLE utilities
(id INT AUTO_INCREMENT PRIMARY KEY, premise MEDIUMINT UNSIGNED, address VARCHAR(255), customer MEDIUMINT UNSIGNED,
service_type VARCHAR(4), service_number SMALLINT UNSIGNED, service_rate VARCHAR(4), consumption FLOAT,
days_of_service SMALLINT UNSIGNED, unit_of_measure VARCHAR(4), charge_amount FLOAT,
charge_date DATE,day SMALLINT UNSIGNED, month SMALLINT UNSIGNED, year SMALLINT UNSIGNED);''')
print("created table 'utilities'")
#add utilities data
pathstring="~/Dropbox/CDS-2019-AlbanyHub/Processed-Data/Totals"
for i in range(2012, 2020):
    df= pd.read_csv(pathstring+str(i)+".csv")
    df = df.drop(['City', 'State', 'Month', 'Year'], axis=1)
    df_list = list(df.where(pd.notnull(df), None).itertuples(index=False, name=None))
    sql = '''INSERT INTO utilities
    (id, premise, address, customer, service_type, service_number, service_rate, 
    consumption,days_of_service, unit_of_measure, charge_amount, charge_date)
    VALUES (default, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'''
    for j in range(len(df_list)//100000):
        mycursor.executemany(sql, df_list[j*100000:(j+1)*100000])
        print(mycursor.rowcount, "was inserted (year "+str(i)+")")
    mycursor.executemany(sql, df_list[(j+1)*100000:])
    print(mycursor.rowcount, "was inserted (year "+str(i)+")")
mydb.commit()