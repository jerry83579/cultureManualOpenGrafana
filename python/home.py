import pandas as pd
import numpy as np
import sys,mysql.connector
from mainConfig import *

# 合併資料
def merge():
    for i in range(1, dataLength+1):

        location = str(i)
        initial_data = '../initialize/' + location + '.csv'
        chebychev_data = '../chebychev/'+location+'.csv'
        arima = '../arima/'+location+'.csv' 
        lstm  = '../lstm/'+location+'.csv' 
        mainMethod = arima if method == 'arima' else lstm
        method_temp= method+'_temp'
        method_hum= method+'_hum'

        try:
            data1 = pd.read_csv(initial_data)
            data2 = pd.read_csv(chebychev_data)
            data3 = pd.read_csv(mainMethod)
        except FileNotFoundError:
            print("發生錯誤,找不到資料")
            sys.exit()

    
        date = data2['LocalTime'].tolist()
        initial_temp = data1['Temp'].tolist()
        initial_hum = data1['Hum'].tolist()
        chebychev_temp = data2['Temp'].tolist()
        chebychev_hum = data2['Hum'].tolist()
        mainMethod_temp = data3['Temp'].tolist()
        mainMethod_hum = data3['Hum'].tolist()
        # tag_temp = data3['Temp_m'].tolist()
        # tag_hum = data3['Hum_m'].tolist()

        for i in range(len(initial_temp)):
            if np.isnan(initial_temp[i]):
                initial_temp[i] = "\\N"

        # for i, v in enumerate(initial_temp):
        #     if np.isnan(v):
        #         initial_temp[i] = "NULL"

        for i in range(len(initial_hum)):
            if np.isnan(initial_hum[i]):
                initial_hum[i] = "\\N"

        for i in range(len(chebychev_temp)):
            if np.isnan(chebychev_temp[i]):
                chebychev_temp[i] = "\\N"

        for i in range(len(chebychev_hum)):
            if np.isnan(chebychev_hum[i]):
                chebychev_hum[i] = "\\N"

        for i in range(len(mainMethod_temp)):
            if np.isnan(mainMethod_temp[i]):
                mainMethod_temp[i] = "\\N"

        for i in range(len(mainMethod_hum)):
            if np.isnan(mainMethod_hum[i]):
                mainMethod_hum[i] = "\\N"

        # for i in range(len(tag_temp)):
        #     if tag_temp[i] == "X":
        #         tag_temp[i] = ""

        # for i in range(len(tag_hum)):
        #     if tag_hum[i] == "X":
        #         tag_hum[i] = ""

        z = {
            'localtime': date,
            'initial_temp': initial_temp,
            'initial_hum': initial_hum,
            'chebychev_temp': chebychev_temp,
            'chebychev_hum': chebychev_hum,
            method_temp: mainMethod_temp,
            method_hum: mainMethod_hum,
        }
        # 'temp_tag' : tag_temp,
        #     'hum_tag' : tag_hum,

        if len(z['localtime']) == len(z['initial_temp']) == len(z['chebychev_temp']) == len(z[method_temp]):
            excel = pd.DataFrame(z)
            names = '../outcome/location_'+location+'.csv'
            excel.to_csv(names, index=False)
            print('已合併成location_'+location)
        else:
            deleted = len(z['initial_temp'])-len(z['localtime'])
            del z['initial_temp'][-deleted:]
            del z['initial_hum'][-deleted:]
            print(len(z['localtime']))
            print(len(z['initial_temp']))
            print(len(z['chebychev_temp']))
            print(len(z[mainMethod_temp]))
            excel = pd.DataFrame(z)
            names = '../outcome/location_'+location+'.csv'
            excel.to_csv(names, index=False)
            print('已合併成location_'+location)


# 新增資料庫
def createMysqldata():
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
       
    sql3 = "CREATE TABLE mapping (id int NOT NULL AUTO_INCREMENT,name varchar(30) NOT NULL,location varchar(30), PRIMARY KEY (id) )"
    mycursor.execute(sql3)
    # create table mapping

    for i in range(1, dataLength+1):
        dataOne = 'location'+str(i)
        dataTwo= 'location_'+str(i)
       
        sql1="CREATE TABLE {} (timestamp DATETIME NOT NULL ,\
        initial_temp DECIMAL(10,2) NULL DEFAULT NULL ,\
        initial_hum DECIMAL(10,2) NULL DEFAULT NULL ,\
        chebychev_temp DECIMAL(10,2) NULL DEFAULT NULL ,\
        chebychev_hum DECIMAL(10,2) NULL DEFAULT NULL ,\
        {}_temp DECIMAL(10,2) NULL DEFAULT NULL ,\
        {}_hum DECIMAL(10,2) NULL DEFAULT NULL )".format(dataOne,method,method)
        mycursor.execute(sql1)
        # create table location%s

        sql2 = "LOAD DATA INFILE '{}{}.csv' INTO TABLE {} FIELDS TERMINATED BY ',' IGNORE 1 LINES ".format(mysqlPath,dataTwo,dataOne)
        mycursor.execute(sql2)
         # import data

      
        sql4 = "INSERT INTO mapping (name, location) VALUES ('{}', '{}')".format(mapping_fieldname[i-1],dataOne)
        mycursor.execute(sql4)
        # mapping
        
        mydb.commit()
        
        
        
        
# 開始
sysdata = sys.argv[1]
dataLength=int(sysdata)
merge()
createMysqldata()
print("建立成功")