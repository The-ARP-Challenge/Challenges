"""
Challenge 001 - Join to Range
Author: Philip Mannering
Date: 2018-09-07
"""


import pandas as pd

# Read the files
ranges = pd.read_csv("./files/range.csv")
customer = pd.read_csv("./files/customer.csv",  index_col=-1)
output = pd.read_csv("../files/output.csv")

#%% Generate the rows

df = ranges

# Split out start and end of range and add to the dataframe
df[['rng1','rng2']] = df.Range.str.extract('(\d+)-(\d+)').astype(int)

# Transpose the new columns
df = df.melt(id_vars=df.columns[:-2])

# Set the index to value
df = df.set_index('value').sort_index()

# Expand range - this is the generate rows bit
df = df.reindex(range(df.index.min(),df.index.max()+1), method = 'ffill')

# =============================================================================
# Should really fill in the range by this group
# dg = df.groupby('Region')
# df = dg.apply(lambda x: x.set_index(x['value'])
#             .reindex(range(x.value.min(),x.value.max()+1)))
# =============================================================================

#df = df.reset_index().drop(columns = ['Range','Expect Revenue','variable'])

#%% Join
df = df.join(customer)

#%% Summarize

# Fields to groupby 
key = ['Region','Sales Rep', 'Responder']

# Group
df = df.groupby(key, as_index=False)['Customer ID'].count()
df = df.rename(columns={'Customer ID':'Count'})


#%% Check answer
(df == output).all()