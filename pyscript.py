import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

#Reference: https://datatofish.com/use-pandas-to-calculate-stats-from-an-imported-csv-file/
#Reference: https://python-graph-gallery.com/8-add-confidence-interval-on-barplot/

#Atribui o arquivo csv para as variaveis
dataIs = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/is.S.csv')
dataBt = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/bt.S.csv')
dataEp = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/ep.S.csv')
dataCg = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/cg.S.csv')
dataMg = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/mg.S.csv')
dataFt = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/ft.S.csv')
dataSp = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/sp.S.csv')
dataLu = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/lu.S.csv')
#dataIs = pd.read_csv('/home/willian/MeuScript/WillianSoares/Resultado/is.S.csv')

#Calcula a media dos valores na coluna "timeExec" e atribui o resultado a variavel como float
mediaIs = dataIs['timeExec'].mean()
mediaBt = dataBt['timeExec'].mean()
mediaEp = dataEp['timeExec'].mean()
mediaCg = dataCg['timeExec'].mean()
mediaMg = dataMg['timeExec'].mean()
mediaFt = dataFt['timeExec'].mean()
mediaSp = dataSp['timeExec'].mean()
mediaLu = dataLu['timeExec'].mean()

#Imprime o resultado doa media
print mediaIs
print mediaBt
print mediaEp
print mediaCg
print mediaMg
print mediaFt
print mediaSp
print mediaLu