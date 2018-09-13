# -*- coding: utf-8 -*-
"""
Created on Wed Sep  5 20:39:54 2018

@author: Jamie
"""


import pandas as pd

df = pd.read_csv("input file.csv")

df = df.Field_1.str.split(",", expand=True).head()

df.rename(columns={0: 'Poem', 1: 'Poem_ID',2: 'Poem_Read_Date'}, inplace=True)

df['Poem'] = df.Poem.str.replace('"', "")
df['Poem_Read_Date'] = df.Poem_Read_Date.str.replace("'", "")

df.Poem_ID = df.Poem_ID.astype(int)
df['Poem_Read_Date'] = pd.to_datetime(df['Poem_Read_Date'])