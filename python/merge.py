import pandas as pd
import numpy as np
import sys
length=sys.argv[1]
for i in range(1,int(length)+1):
# i=12  
    location = str(i)
    initial_data = './initialize/'+ location + '.csv'
    chebychev_data = './chebychev/'+location+'.csv'
    arima = './arima/'+location+'.csv'
    data1 = pd.read_csv(initial_data)
    data2 = pd.read_csv(chebychev_data)
    data3 = pd.read_csv(arima)



    date = data2['LocalTime'].tolist()
    initial_temp = data1['Temp'].tolist()
    initial_hum = data1['Hum'].tolist()
    chebychev_temp = data2['Temp'].tolist()
    chebychev_hum = data2['Hum'].tolist()
    arima_temp = data3['Temp'].tolist()
    arima_hum = data3['Hum'].tolist()
    
    # tag_temp = data3['Temp_m'].tolist()
    # tag_hum = data3['Hum_m'].tolist()
    
    for i in range(len(initial_temp)):
        if np.isnan(initial_temp[i]):
            initial_temp[i] = "\\N"

    for i in range(len(initial_hum)):
        if np.isnan(initial_hum[i]):
            initial_hum[i] = "\\N"

    for i in range(len(chebychev_temp)):
        if np.isnan(chebychev_temp[i]):
            chebychev_temp[i] = "\\N"

    for i in range(len(chebychev_hum)):
        if np.isnan(chebychev_hum[i]):
            chebychev_hum[i] = "\\N"

    for i in range(len(arima_temp)):
        if np.isnan(arima_temp[i]):
            arima_temp[i] = "\\N"

    for i in range(len(arima_hum)):
        if np.isnan(arima_hum[i]):
            arima_hum[i] = "\\N"

    # for i in range(len(tag_temp)):
    #     if tag_temp[i] == "X":
    #         tag_temp[i] = ""

    # for i in range(len(tag_hum)):
    #     if tag_hum[i] == "X":
    #         tag_hum[i] = ""

    z = {
        'localtime' : date,
        'initial_temp' : initial_temp,
        'initial_hum' : initial_hum,
        'chebychev_temp' : chebychev_temp,
        'chebychev_hum' : chebychev_hum,
        'arima_temp' : arima_temp,
        'arima_hum' : arima_hum,
        # 'temp_tag' : tag_temp,
        # 'hum_tag' : tag_hum,
    }

    if len(z['localtime'])==len(z['initial_temp'])==len(z['chebychev_temp'])==len(z['arima_temp']):
        excel = pd.DataFrame(z)
        names = './outcome/location_'+location+'.csv'
        excel.to_csv(names,index=False)
        print('excel '+location+' transformed A plan')
    else:
        deleted = len(z['initial_temp'])-len(z['localtime'])
        del z['initial_temp'][-deleted:]
        del z['initial_hum'][-deleted:]
        print(len(z['localtime']))
        print(len(z['initial_temp']))
        print(len(z['chebychev_temp']))
        print(len(z['arima_temp']))
        excel = pd.DataFrame(z)
        names = './outcome/location_'+location+'.csv'
        excel.to_csv(names,index=False)
        print('excel '+location+' transformed B plan')
    




