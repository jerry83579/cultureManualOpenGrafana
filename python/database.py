import mysql.connector
print("新增資料庫名稱:")
databaseName = input()
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password=""
)

mycursor = mydb.cursor()

mycursor.execute(" CREATE DATABASE " + databaseName)
mydb.database=databaseName
mycursor.execute("CREATE TABLE customers (name VARCHAR(255), address VARCHAR(255))")
