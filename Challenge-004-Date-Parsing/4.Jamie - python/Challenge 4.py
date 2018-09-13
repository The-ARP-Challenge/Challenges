# -*- coding: utf-8 -*-
"""
Created on Sat Sep  8 08:09:57 2018

@author: Jamie
"""

import pandas as pd
import numpy as np


df = pd.read_csv("input.csv")


df['Date'] = df['Field_1'].str.findall(r'[\d]{1,2}-[a-zA-Z]\w*-[\d]{2,4}|[a-zA-Z]\w*\s[\d]{2},\s[\d]{4}|[a-zA-Z]\w*\s[\d]{1}\s[\d]{4}')


df['Date'] = df['Date'].str[0]


year = df['Date'].str.findall(r'[\d]{4}|-[\d]{2,4}')

year = year.str[0]

year = year.str.replace("-","")

year = year.astype(int)

m1 = year < 17
m2 = (year > 17) & (year < 100)

a1 = year + 2000
a2 = year + 1900
a3 = year 

df['Year'] = np.select([m1, m2], [a1, a2], default=a3)

df['Year']  = df['Year'] .astype(str)


month = df['Date'].str.findall(r'[a-zA-Z]\w*')

month = month.str[0]

month = month.str[:3]

df['Month'] = month.str.upper()

day = df['Date'].str.findall(r'\s[\d]{1}\s|[\d]{1,2}-|[\d]{2},')

day = day.str[0]

day = day.str.replace("-","")

day = day.str.replace(",","")

day = day.str.replace(" ","")

df['Day']  = np.where(day.str.len()==1, '0'+day,day)

df['Date']= pd.to_datetime(df['Year']+'/'+df['Month']+'/'+df['Day'], format='%Y/%b/%d')

df = df.drop(['Day','Month','Year'], axis=1)
