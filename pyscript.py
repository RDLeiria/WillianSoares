#usado na parte de criacao dos graficos
import numpy as np
import matplotlib.pyplot as plt
#usado na parte do csv
import pandas as pd

#Reference: https://datatofish.com/use-pandas-to-calculate-stats-from-an-imported-csv-file/
#Reference: https://python-graph-gallery.com/8-add-confidence-interval-on-barplot/

#Atribui o arquivo csv para as variaveis
dataIs = pd.read_csv('/home/willian/WillianSoares/Resultado/is.S.csv')
dataBt = pd.read_csv('/home/willian/WillianSoares/Resultado/bt.S.csv')
dataEp = pd.read_csv('/home/willian/WillianSoares/Resultado/ep.S.csv')
dataCg = pd.read_csv('/home/willian/WillianSoares/Resultado/cg.S.csv')
dataMg = pd.read_csv('/home/willian/WillianSoares/Resultado/mg.S.csv')
dataFt = pd.read_csv('/home/willian/WillianSoares/Resultado/ft.S.csv')
dataSp = pd.read_csv('/home/willian/WillianSoares/Resultado/sp.S.csv')
dataLu = pd.read_csv('/home/willian/WillianSoares/Resultado/lu.S.csv')
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
print "IS " + str(mediaIs)
print "BT " + str(mediaBt)
print "EP " + str(mediaEp)
print "CG " + str(mediaCg)
print "MG " + str(mediaMg)
print "FT " + str(mediaFt)
print "SP " + str(mediaSp)
print "LU " + str(mediaLu)

#--------------------Criacao dos graficos ---------------------------

# largura das barras
barWidth = 0.3

# Choose the height of the blue bars
bars1 = [mediaIs, mediaBt, mediaEp, mediaCg, mediaMg, mediaFt, mediaSp, mediaLu]
 
# Choose the height of the red bars
#bars2 = [10.8, 9.5, 4.5, 10.8, 9.5, 4.5, 10.8, 9.5]

# Choose the height of the green bars
#bars3 = [10.8, 9.5, 4.5, 10.8, 9.5, 4.5, 10.8, 9.5]
 
# Choose the height of the error bars (bars1)
yer1 = [0, 0, 0, 0, 0, 0, 0, 0]
 
# Choose the height of the error bars (bars2)
#yer2 = [0.5, 0.4, 0.5, 0.5, 0.4, 0.5, 0.5, 0.4]

# Choose the height of the error bars (bars3)
#yer3 = [0.5, 0.4, 0.5, 0.5, 0.4, 0.5, 0.5, 0.4]

# The x position of bars
r1 = np.arange(len(bars1))
#r2 = [x + barWidth for x in r1]
#r3 = [x + barWidth for x in r2]

# Create blue bars
plt.bar(r1, bars1, width = barWidth, color = 'blue', edgecolor = 'black', yerr=yer1, capsize=7, label='Serial')
 
# Create red bars
#plt.bar(r2, bars2, width = barWidth, color = 'red', edgecolor = 'black', yerr=yer2, capsize=7, label='KVM')

# Create green bars
#plt.bar(r3, bars3, width = barWidth, color = 'gray', edgecolor = 'black', yerr=yer3, capsize=7, label='Native')
 
# general layout
plt.xticks([r + barWidth for r in range(len(bars1))], ['IS', 'EP', 'CG', 'MG', 'FT', 'BT', 'SP', 'LU'])
plt.ylabel('Time in seconds (Lower is better) ')
plt.xlabel('Benchmarks')
plt.legend()

# Show graphic
plt.show()