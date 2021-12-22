import requests
import pandas as pd
import copy
import json
import numpy as np
import subprocess, sys
count=0
headers = {
    'Accept':'application/json',
    'Authorization': 'Bearer eyJrIjoiU08wSDcyOFZvM1BiYVZFNHhpWUdvazFWdmVseUdMeFgiLCJuIjoia2V5IiwiaWQiOjF9',
    'Content-Type': 'application/json',
}
uid=sys.argv[1]


r = requests.get('http://localhost:3000/api/dashboards/uid/'+uid,headers=headers,verify=False)
dash_data=r.json()

# 該圖表站別數量
try:
    dataLength=len(dash_data["dashboard"]["templating"]["list"][0]["options"])
except:
    print("oops , that was wrong pls try again...")
# 顯示可選站別
for item in dash_data["dashboard"]["templating"]["list"][0]["options"]:
    print(count,")"," ",item["text"],sep='')
    count+=1

print("\n")




def selectStop():
    global selectSt
    selectSt = input("請選擇站別:")
    # 判斷使用者輸入為數字和為正整數
    if  selectSt.isdigit() and int(selectSt)<dataLength:
        # 選擇已選站別
        dash_data["dashboard"]["templating"]["list"][0]["current"]["text"]=dash_data["dashboard"]["templating"]["list"][0]["options"][int(selectSt)]["text"]
        dash_data["dashboard"]["templating"]["list"][0]["current"]["value"]=dash_data["dashboard"]["templating"]["list"][0]["options"][int(selectSt)]["text"]
        dash_data["dashboard"]["templating"]["list"][0]["options"][int(selectSt)]["selected"]=True
        for i in range(0,count-1):
            if i != int(selectSt):
                dash_data["dashboard"]["templating"]["list"][0]["options"][i]["selected"]=False
        r = requests.post('http://localhost:3000/api/dashboards/db',headers=headers,data=json.dumps(dash_data),verify=False) 
    else:
        print("請重新選擇")
        selectStop()
    
selectStop()
