# Mysqlc config
host="localhost"
username="root"
password="root"
database="myfirst"
mysqlPath="C:/xampp/htdocs/dashboard/cultureManualOpenGrafana/outcome/" # Mysql 讀取資料路徑 預設為cultureManualOpenGrafana/outcome

mapping_fieldname=[ # 站名順序
    "1.台南綜合氣象站",
    "2.台中綜合氣象站",
    "",
]

# 主程式 Config
filename=""
method="" # arima or lstm
outputPath=""
arima_hyper_parameter={
    "time":"dd/mm/YY HH:MM:SS",
}
lstm_hyper_parameter={
    "time":"dd/mm/YY HH:MM:SS",
}

# Grafana Config
apiAuthorization="eyJrIjoiU08wSDcyOFZvM1BiYVZFNHhpWUdvazFWdmVseUdMeFgiLCJuIjoia2V5IiwiaWQiOjF9"
url="http://localhost:3000"


