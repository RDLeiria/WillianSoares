import pandas as pd

#Atribui o arquivo csv para as variaveis
dataBt = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/bt.S.csv')
#dataIs = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/is.S.csv')
#dataFt = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/ft.S.csv')

#Calcula a media dos valores na coluna "timeExec" e atribui o resultado a variavel como float
btmedia = dataBt['timeExec'].mean()

#Imprime o resultado doa media
print btmedia

#print (dataBt.mean())
#print (dataIs.mean())
#print (dataFt.mean())