# Challenge 001
#


#%% Read the files

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


df = pd.read_csv("./files/range.csv")
customer = pd.read_csv("./files/customer.csv")


#%% Generate rows within the DataFrame

d = df

d['rng1'] = d['Range'].str.extract('(\d+)')
d['rng2'] = d['Range'].str.extract('-(\d+)')

d = d.melt(id_vars=d.columns[:-2])

d['value'] = d['value'].astype('int32')
d = d.set_index('value', drop=False).sort_index()

d = d.reindex(range(d.value.min(),d.value.max()+1))

# =============================================================================
# Should really fill in the range by this group
# dg = d.groupby('Region')
# d = dg.apply(lambda x: x.set_index(x['value'])
#             .reindex(range(x.value.min(),x.value.max()+1)))
# =============================================================================

d = d.fillna(method = 'ffill')
d.value = d.index


