import pandas as pd

##importing files
cust = pd.read_csv('C:\\Users\\jevon\\Documents\\Weekly challenges Python R\\1\\customer_info.csv')
reg = pd.read_csv('C:\\Users\\jevon\\Documents\\Weekly challenges Python R\\1\\region_info.csv')

##creating a dataframe
reg1 = pd.DataFrame(reg)
cus = pd.DataFrame(cust)

##splitting up the range to two columns, upperbound and lowerbound 
reg1[['lowerbound','upperbound']] = reg1.Range.str.split('-',expand = True).astype(int)

##creating the new table                    
new_columns = list(reg1.columns.values) + ['iterate_number']               
new_reg1 = pd.DataFrame(columns=new_columns)

##defining the loop iterates over each line in reg1
##which lists all integer values  
##between the lower and upper bound 
newreg1_index = 0                                                                                                            
for i, row in reg1.iterrows():
    ub = row['upperbound']
    lb = row['lowerbound']
    for j in range(lb,ub+1):
        iterate_number = j
        new_reg1.loc[newreg1_index] = row.values.tolist() + [iterate_number]
        newreg1_index = newreg1_index + 1

##getting rid of un-needed columns                                                     
reduced = new_reg1.drop(['Range','lowerbound','upperbound'],axis = 1)

##joining on required field, HAVE to set the index first
##before we join
joined = cus.set_index('Postal Area').join(reduced.set_index('iterate_number'))
data = pd.DataFrame(joined)

print(data.groupby(['Region','Sales Rep'])['Responder'].value_counts())



