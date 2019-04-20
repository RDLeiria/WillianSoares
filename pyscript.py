import pandas as pd

dataBt = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/bt.S.csv')
dataIs = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/is.S.csv')
dataFt = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/ft.S.csv')

print (dataBt.mean())
print (dataIs.mean())
print (dataFt.mean())