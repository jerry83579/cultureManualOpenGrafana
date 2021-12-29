import requests
import pandas as pd
import numpy as np
from mainConfig import *

headers = {
    'Accept':'application/json',
    'Authorization': 'Bearer '+apiAuthorization+'',
    'Content-Type': 'application/json',
}
r = requests.get('{}/api/search'.format(url),headers=headers,verify=False)
dash_data=r.json()
dash_data_len=len(dash_data)
count=0

# 提供選擇圖表
for item in dash_data:
    print(count,")"," ",item["title"],sep='')
    count+=1
    dashboardSum=count
print("\n")   

# 選擇圖表
def selectDashboard():
    global selectDash
    selectDash = input("請選擇圖表:") 
    # 判斷使用者輸入為數字和為正整數
    if  selectDash.isdigit() and int(selectDash)<dashboardSum:
        # 顯示已選圖表
        # 將已選圖表之UID，URL，TITLE寫入TXT傳直
        data=open("data.txt",'w+') 
        print(dash_data[int(selectDash)]["uid"],file=data)
        print(dash_data[int(selectDash)]["url"],file=data)
        print(dash_data[int(selectDash)]["title"],file=data)
        data.close()
    else:
        print("請重新選擇")
        selectDashboard()
    
selectDashboard()
    
    
    










