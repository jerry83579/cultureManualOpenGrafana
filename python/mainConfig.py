# Mysqlc Config
host='localhost' # Mysql位址
username='root' # Mysql帳號
password='root' # Mysql密碼
database='myfirst' # 資料庫名稱
mysqlPath='C:/xampp/htdocs/dashboard/cultureManualOpenGrafana/outcome/' # Mysql讀取資料到資料庫的路徑 

mapping_fieldname=[ # 站名順序
    '1.台南綜合氣象站',
    '2.台中綜合氣象站',
    '',
]

# Main Config
filename=''
method='arima' # arima 或 lstm
outputPath=""
arima_hyper_parameter={
    "time":"dd/mm/YY HH:MM:SS",
}
lstm_hyper_parameter={
    "time":"dd/mm/YY HH:MM:SS",
}

# Grafana Config
apiAuthorization="eyJrIjoiU08wSDcyOFZvM1BiYVZFNHhpWUdvazFWdmVseUdMeFgiLCJuIjoia2V5IiwiaWQiOjF9" # api 授權
url="http://localhost:3000" # Grafana 連接埠


