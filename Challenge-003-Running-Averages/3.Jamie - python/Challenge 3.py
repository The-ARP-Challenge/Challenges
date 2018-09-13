# -*- coding: utf-8 -*-
"""
Created on Fri Sep  7 21:34:14 2018

@author: Jamie
"""

import pandas as pd

df = pd.read_csv("input.csv")

df = df.fillna(0)


dfa = (df.groupby(['HP Category'])
                  .rolling(window=3, min_periods=1).mean())

dfa = dfa.drop(['HP Category', 'Year', 'Month'], axis=1)

dfa= dfa.add_suffix('_3mths')

dfb = (df.groupby(['HP Category'])
                  .rolling(window=6, min_periods=1).mean())

dfb = dfb.drop(['HP Category', 'Year', 'Month'], axis=1)

dfb= dfb.add_suffix('_6mths')

dfc = dfa.join(dfb)

dfc= dfc.reset_index()

df = pd.merge(df, dfc, left_index=True, right_index=True)


df = df.drop(['level_1'], axis=1)

df.to_csv('out.csv')