"""
Challenge 002 - Preparing Delimited Data
Author: Philip Mannering
Date: 2018-09-07
"""

import pandas as pd

df = pd.read_csv('../files/input.csv')
# Read in the answer and convert the 3rd column to datetime
output = pd.read_csv('../files/output.csv', parse_dates=[2])

#%% Parse

# text to columns
df = df.Field_1.str.split(',', expand=True)
df.columns = ['Poem','Poem_ID','Poem_Read_Date']

# Remove quotes and set datatype
df.Poem = df.Poem.str.strip('"')
df.Poem_ID = df.Poem_ID.astype('int64')
df.Poem_Read_Date = pd.to_datetime(df.Poem_Read_Date)


#%% Check answer

# Datatypes must match
df.equals(output)