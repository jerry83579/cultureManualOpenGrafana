import requests
import pandas as pd
import copy
import json
import numpy as np
import subprocess, sys
from mainConfig import *

headers = {
    'Accept':'application/json',
    'Authorization': 'Bearer {}'.format(apiAuthorization),
    'Content-Type': 'application/json',
}
uid=sys.argv[1]
r = requests.get('{}/api/dashboards/uid/{}'.format(url,uid),headers=headers,verify=False)
dash_data=r.json()


# 該圖表站別數量
def stopAmount():
        count=0
        dataLength=len(dash_data["dashboard"]["templating"]["list"][0]["options"])
        for item in dash_data["dashboard"]["templating"]["list"][0]["options"]:
            print(count,")"," ",item["text"],sep='')
            count+=1
           
   
       




def selectStop():
    count=0
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
        r = requests.post('{}/api/dashboards/db'.format(url),headers=headers,data=json.dumps(dash_data),verify=False) 
    else:
        print("請重新選擇")
        selectStop()


resultCode = stopAmount()
selectStop()
