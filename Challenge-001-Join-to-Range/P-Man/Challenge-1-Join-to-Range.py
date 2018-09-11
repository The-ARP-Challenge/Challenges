import numpy as np
import pandas as pd

a = 'hello world'

df = pd.DataFrame({'a':['a','b','c'],
                  'b':[1,2,3]})

df['c'] = df['a']*df['b']

df = df.set_index('b')
df = df.stack()

print(df)

import matplotlib.pyplot as plt
plt.plot([1,2,3],[4,5,6])
plt.title('My first plot')
plt.show()