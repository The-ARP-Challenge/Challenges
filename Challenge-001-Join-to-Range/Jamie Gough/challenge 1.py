# -*- coding: utf-8 -*-
"""
Created on Sat Sep  1 11:50:58 2018

@author: Jamie
"""


import pandas as pd
import numpy as np

#df = pd.read_csv("C:\\Users\\Jamie\\Desktop\\Weekly challenge\\1\\reps.csv")
# Relative file path
df = pd.read_csv("reps.csv")


df[['Start','End']] = df.Range.str.split("-", expand=True).head()

#splits Range into two columns


df.rename(columns={'Sales Rep': 'Sales_Rep', 'Expect Revenue': 'Expect_Revenue'}, inplace=True)

df.Start = df.Start.astype(int)
df.End = df.End.astype(int)
#change to integars for itertuples range

df_input = []
#empty list to add new dataset too

for r in df.itertuples():
  for rg in range(r.Start,r.End+1):
      #Takes range for crearing rows from each row (r.)
      df_input.append({'Region':r.Region,'Range':r.Range,'Expect_Revenue':r.Expect_Revenue, 'Sales_Rep': r.Sales_Rep, 'Start': r.Start, 'End':r.End, 'Area':rg})
      #appends relevant columns including rg that becomes area for the join
      df = pd.DataFrame(df_input)



#dfb = pd.read_csv("C:\\Users\\Jamie\\Desktop\\Weekly challenge\\1\\postal area.csv")
dfb = pd.read_csv("postal area.csv")

dfc = dfb.set_index('Postal Area').join(df.set_index('Area'))

df=(dfc.groupby(['Region','Sales_Rep','Responder'])
                  .agg({'Customer ID': [np.size]})
                  .rename(columns={'size': 'Count'}))
#groupsby the 3 required columns and counts customer ids

df.reset_index()
#Add index to table