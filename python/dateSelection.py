import requests
import pandas as pd
import copy
import json
import numpy as np
import subprocess, sys
from mainConfig import *

uid=sys.argv[1]
array_from_file = np.loadtxt("../test.txt", dtype=str)
new=np.array_str(array_from_file)
timeFrom=new[2:26]
timeTo=new[29:-2]

headers = {
    'Accept':'application/json',
    'Authorization': 'Bearer {}'.format(apiAuthorization),
    'Content-Type': 'application/json',
}
new_dashboard_data={
    "dashboard": {
    "time":{
    "from": timeFrom, 
    "to": timeTo,
    },
  },
    "overwrite":False
}
dashboard_data=copy.deepcopy(new_dashboard_data)
# 要修改的json資料
r = requests.get('{}/api/dashboards/uid/{}'.format(url,uid),headers=headers,verify=False)
dash_data=r.json()


# grafana上的json資料
dash_data["dashboard"]["time"]["from"]=dashboard_data["dashboard"]["time"]["from"]
dash_data["dashboard"]["time"]["to"]=dashboard_data["dashboard"]["time"]["to"]
dash_data["dashboard"]["overwrite"]=True
r = requests.post('{}/api/dashboards/db'.format(url),headers=headers,data=json.dumps(dash_data),verify=False)







