import pandas as pd
import numpy as np
import sys
location = str(1)
arima = './arima/'+location+'.csv'
data3 = pd.read_csv(arima)
print(data3['Temp_m'])


# if data3['Temp_m']== "\\N":
#     print(data3['Temp_m'])
#     print("空")
# else:
#     print(data3['Temp_m'])
#     print("不為空")