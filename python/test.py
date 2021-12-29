import pandas as pd
import numpy as np
import sys,mysql.connector
from mainConfig import *

while True:  
        try:
            mydb = mysql.connector.connect(
            host="{}".format(host), 
            user="{}".format(username),
            password="{}".format(password)
        )
            mycursor = mydb.cursor()
            mycursor.execute(" CREATE DATABASE " + database)#
            mydb.database = database
            break
        except mysql.connector.Error as err:
            if err.errno==1064:
                print("資料庫命名錯誤,請重新嘗試")
                sys.exit(1)
            if err.errno==1007:
                print("資料庫重複命名,請重新嘗試")
                sys.exit(1)
       
            
    for i in range(5):
        dataOne = 'location'+str(i)
        dataTwo= 'location_'+str(i)
        mycursor.execute("CREATE TABLE {location}(timestamp DATETIME NOT NULL ,\
        initial_temp DECIMAL(10,2) NULL DEFAULT NULL ,\
        initial_hum DECIMAL(10,2) NULL DEFAULT NULL ,\
        chebychev_temp DECIMAL(10,2) NULL DEFAULT NULL ,\
        chebychev_hum DECIMAL(10,2) NULL DEFAULT NULL ,\
        arima_temp DECIMAL(10,2) NULL DEFAULT NULL ,\
        arima DECIMAL(10,2) NULL DEFAULT NULL )".format(location=dataOne))
    
        sql2 = "LOAD DATA INFILE '{}{}.csv' INTO TABLE {} FIELDS TERMINATED BY ',' IGNORE 1 LINES ".format(mysqlPath,dataTwo,dataOne)
        mycursor.execute(sql2)
        mydb.commit()
        print("建立成功")