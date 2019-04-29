# usado para receber argumentos
import sys
# usado  na parte de criacao dos graficos
import numpy as np
import matplotlib.pyplot as plt
# usado na parte do csv
import pandas as pd

#Trabalhando com csv e pythom, reference: https://datatofish.com/use-pandas-to-calculate-stats-from-an-imported-csv-file/
#Trabalhando com graficos e python, reference: https://python-graph-gallery.com/8-add-confidence-interval-on-barplot/


# Teste de passagem de argumento do arquivo script.sh
classe = sys.argv[1]
processos = sys.argv[2]

print "A classe eh: "+classe
print "Quantidade de processos: "+processos


#-------------------- Gera os sufixos dos csv ------------------------------------------------------

listaBenchmarks = ["is", "ep", "cg", "mg", "ft", "bt", "sp", "lu"]
detalhesBenchmarks=[]
for x in xrange(0,8):
	#cria os sufixos ex: "is.S.1" para montar os graficos
	y = (listaBenchmarks[x]+"."+classe+"."+processos)
	detalhesBenchmarks.append(y)

#-------------------- Leitura do conteudo csv ------------------------------------------------------

readData=[]
for x in xrange(0,8):
	y = pd.read_csv('~/WillianSoares/Resultado/'+detalhesBenchmarks[x]+'.csv')
	readData.append(y)

#-------------------- Calcula a media dos benchmarks do conteudo csv -------------------------------

timeExecMean=[]
for x in xrange(0,8):
	y = readData[x]['timeExec'].mean()
	timeExecMean.append(y)


#--------------------Imprime o conteudo dos graficos de barra --------------------------------------

for x in xrange(0,8):
	print (listaBenchmarks[x], timeExecMean[x])

#--------------------Criacao dos graficos de barra -------------------------------------------------

# largura das barras
barWidth = 0.3

# Choose the height of the blue bars
bars1 = [timeExecMean[0], timeExecMean[1], timeExecMean[2], timeExecMean[3], 
		timeExecMean[4], timeExecMean[5], timeExecMean[6], timeExecMean[7]]
 
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
plt.bar(r1, bars1, width = barWidth, color = 'blue', edgecolor = 'black', yerr=yer1, capsize=7, label='Nativo')
 
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
#plt.show()

# Save as pdf
plt.savefig("Graficos/class-"+classe+"-procs-"+processos+".pdf")