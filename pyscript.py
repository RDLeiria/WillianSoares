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
#classe = sys.argv[1]
#processos = sys.argv[2]

classe="S"
processos=str(1)

print "A classe eh: "+classe
print "Quantidade de processos: "+processos

listaBenchmarks = ["is", "ep", "cg", "mg", "ft", "bt", "sp", "lu"]

#-------------------- Gera os sufixos dos csv ------------------------------------------------------

# Nativo
nativoDetalhesBenchmarks=[]
for x in xrange(0,8):
	#cria os sufixos ex: "is.S.1" para montar os graficos
	y = ("Nativo."+listaBenchmarks[x]+"."+classe+"."+processos)
	nativoDetalhesBenchmarks.append(y)

# KVM
kvmDetalhesBenchmarks=[]
for x in xrange(0,8):
	#cria os sufixos ex: "is.S.1" para montar os graficos
	y = ("KVM."+listaBenchmarks[x]+"."+classe+"."+processos)
	kvmDetalhesBenchmarks.append(y)

# ESXi
esxiDetalhesBenchmarks=[]
for x in xrange(0,8):
	#cria os sufixos ex: "is.S.1" para montar os graficos
	y = ("ESXi."+listaBenchmarks[x]+"."+classe+"."+processos)
	esxiDetalhesBenchmarks.append(y)

#-------------------- Leitura do conteudo csv ------------------------------------------------------

# Nativo
nativoReadData=[]
for x in xrange(0,8):
	y = pd.read_csv('~/WillianSoares/NativoResultado/'+nativoDetalhesBenchmarks[x]+'.csv')
	nativoReadData.append(y)

# KVM
kvmReadData=[]
for x in xrange(0,8):
	y = pd.read_csv('~/WillianSoares/KVMResultado/'+kvmDetalhesBenchmarks[x]+'.csv')
	kvmReadData.append(y)

# ESXi
esxiReadData=[]
for x in xrange(0,8):
	y = pd.read_csv('~/WillianSoares/ESXiResultado/'+esxiDetalhesBenchmarks[x]+'.csv')
	esxiReadData.append(y)

#-------------------- Calcula a media dos benchmarks do conteudo csv -------------------------------

# Nativo
nativoTimeExecMean=[]
for x in xrange(0,8):
	y = nativoReadData[x]['timeExec'].mean()
	nativoTimeExecMean.append(y)

# KVM
kvmTimeExecMean=[]
for x in xrange(0,8):
	y = kvmReadData[x]['timeExec'].mean()
	kvmTimeExecMean.append(y)

# ESXi
esxiTimeExecMean=[]
for x in xrange(0,8):
	y = esxiReadData[x]['timeExec'].mean()
	esxiTimeExecMean.append(y)


#--------------------Imprime o conteudo dos graficos de barra --------------------------------------
# Nativo
for x in xrange(0,8):
	print ("Nativo", listaBenchmarks[x], nativoTimeExecMean[x])

# KVM
for x in xrange(0,8):
	print ("KVM ", listaBenchmarks[x], kvmTimeExecMean[x])

# ESXi
for x in xrange(0,8):
	print ("ESXi ", listaBenchmarks[x], esxiTimeExecMean[x])

#--------------------Criacao dos graficos de barra -------------------------------------------------

# largura das barras
barWidth = 0.3

# Choose the height of the blue bars
bars1 = [nativoTimeExecMean[0], nativoTimeExecMean[1], nativoTimeExecMean[2], nativoTimeExecMean[3], 
		nativoTimeExecMean[4], nativoTimeExecMean[5], nativoTimeExecMean[6], nativoTimeExecMean[7]]
 
bars2 = [kvmTimeExecMean[0], kvmTimeExecMean[1], kvmTimeExecMean[2], kvmTimeExecMean[3], 
		kvmTimeExecMean[4], kvmTimeExecMean[5], kvmTimeExecMean[6], kvmTimeExecMean[7]]

bars3 = [esxiTimeExecMean[0], esxiTimeExecMean[1], esxiTimeExecMean[2], esxiTimeExecMean[3], 
		esxiTimeExecMean[4], esxiTimeExecMean[5], esxiTimeExecMean[6], esxiTimeExecMean[7]]
 
# Choose the height of the red bars
#bars2 = [10.8, 9.5, 4.5, 10.8, 9.5, 4.5, 10.8, 9.5]

# Choose the height of the green bars
#bars3 = [10.8, 9.5, 4.5, 10.8, 9.5, 4.5, 10.8, 9.5]
 
# Choose the height of the error bars (bars1)
yer1 = [0, 0, 0, 0, 0, 0, 0, 0]
yer2 = [0, 0, 0, 0, 0, 0, 0, 0]
yer3 = [0, 0, 0, 0, 0, 0, 0, 0]
 
# Choose the height of the error bars (bars2)
#yer2 = [0.5, 0.4, 0.5, 0.5, 0.4, 0.5, 0.5, 0.4]

# Choose the height of the error bars (bars3)
#yer3 = [0.5, 0.4, 0.5, 0.5, 0.4, 0.5, 0.5, 0.4]

# The x position of bars
r1 = np.arange(len(bars1))
r2 = [x + barWidth for x in r1]
r3 = [x + barWidth for x in r2]

# Create blue bars
plt.bar(r1, bars1, width = barWidth, color = 'blue', edgecolor = 'black', yerr=yer1, capsize=7, label='Nativo')
 
# Create red bars
plt.bar(r2, bars2, width = barWidth, color = 'red', edgecolor = 'black', yerr=yer2, capsize=7, label='KVM')

# Create green bars
plt.bar(r3, bars3, width = barWidth, color = 'gray', edgecolor = 'black', yerr=yer3, capsize=7, label='ESXi')
 
# general layout
plt.xticks([r + barWidth for r in range(len(bars1))], ['IS', 'EP', 'CG', 'MG', 'FT', 'BT', 'SP', 'LU'])
plt.ylabel('Time in seconds (Lower is better) ')
plt.xlabel('Benchmarks')
plt.legend()

# Show graphic
#plt.show()

# Save as pdf
plt.savefig("class-"+classe+"-procs-"+processos+".pdf")