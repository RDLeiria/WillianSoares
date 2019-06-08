# -*- coding: utf-8 -*-
# a linha acima possibilia o uso de acentos 

# Utilizado para auxiliar na para chamar novamente o script createGraphs.sh
import subprocess

# usado para receber argumentos
import sys

# usado  na parte de criacao dos graficos
import numpy as np
import matplotlib.pyplot as plt

# usado na parte do csv
import pandas as pd

# utilizado para criar diretorios
import os

# utilizado para caminhar pelos diretorios
import os.path

#Trabalhando com csv e pythom, reference: https://datatofish.com/use-pandas-to-calculate-stats-from-an-imported-csv-file/
#Trabalhando com graficos e python, reference: https://python-graph-gallery.com/8-add-confidence-interval-on-barplot/

# Teste de passagem de argumento do arquivo script.sh
classe = sys.argv[1] 	 # Classe
processos = sys.argv[2]  # Numero de nodos 
exp = sys.argv[3]		 # Experimento executado	

print "A classe eh: "+classe
print "Quantidade de processos: "+processos

if int(processos) == 1 or int(processos) == 4:
	listaBenchmarks = ["is", "ep", "cg", "mg", "ft", "bt", "sp", "lu"]
	listTam = int(len(listaBenchmarks))

if int(processos) == 2:
	listaBenchmarks = ["is", "ep", "cg", "mg", "ft", "lu"]
	listTam = int(len(listaBenchmarks))

if int(processos) == 3 or int(processos) == 5:
	listaBenchmarks = ["ep"]
	listTam = int(len(listaBenchmarks))

if int(processos) == 6:
	listaBenchmarks = ["ep", "lu"]
	listTam = int(len(listaBenchmarks))

#-------------------- Gera os sufixos dos csv ------------------------------------------------------

# Nativo
nativoDetalhesBenchmarks=[]
kvmDetalhesBenchmarks=[]
esxiDetalhesBenchmarks=[]
for x in xrange(0,listTam):
	#cria os sufixos ex: "is.S.1" para montar os graficos
	y1 = ("Nativo."+listaBenchmarks[x]+"."+classe+"."+processos)
	y2 = ("KVM."+listaBenchmarks[x]+"."+classe+"."+processos)
	y3 = ("ESXi."+listaBenchmarks[x]+"."+classe+"."+processos)
	nativoDetalhesBenchmarks.append(y1)
	kvmDetalhesBenchmarks.append(y2)
	esxiDetalhesBenchmarks.append(y3)

#-------------------- Leitura do conteudo csv ------------------------------------------------------

# Nativo
nativoReadData=[]
kvmReadData=[]
esxiReadData=[]
for x in xrange(0,listTam):
	y1 = pd.read_csv('~/WillianSoares/resultados/Experimento'+exp+'/NativoResultado/'+nativoDetalhesBenchmarks[x]+'.csv')
	y2 = pd.read_csv('~/WillianSoares/resultados/Experimento'+exp+'/KVMResultado/'+kvmDetalhesBenchmarks[x]+'.csv')
	y3 = pd.read_csv('~/WillianSoares/resultados/Experimento'+exp+'/ESXiResultado/'+esxiDetalhesBenchmarks[x]+'.csv')
	nativoReadData.append(y1)
	kvmReadData.append(y2)
	esxiReadData.append(y3)

#-------------------- Calcula a media dos benchmarks do conteudo csv -------------------------------

# Nativo
nativoTimeExecMean=[]
kvmTimeExecMean=[]
esxiTimeExecMean=[]
for x in xrange(0,listTam):
	y1 = nativoReadData[x]['timeExec'].mean()
	y2 = kvmReadData[x]['timeExec'].mean()
	y3 = esxiReadData[x]['timeExec'].mean()
	nativoTimeExecMean.append(y1)
	kvmTimeExecMean.append(y2)
	esxiTimeExecMean.append(y3)

#--------------------Imprime o conteudo dos graficos de barra --------------------------------------

# Nativo
for x in xrange(0,listTam):
	print ("Nativo", listaBenchmarks[x], nativoTimeExecMean[x])

# KVM
for x in xrange(0,listTam):
	print ("KVM ", listaBenchmarks[x], kvmTimeExecMean[x])

# ESXi
for x in xrange(0,listTam):
	print ("ESXi ", listaBenchmarks[x], esxiTimeExecMean[x])

#--------------------Criacao dos graficos de barra -------------------------------------------------

# largura das barras
barWidth = 0.3

# Choose the height of the bars
bars1 = nativoTimeExecMean
 
bars2 = kvmTimeExecMean

bars3 = esxiTimeExecMean
 
# Choose the height of the error bars 
#yer1 = [0, 0, 0, 0, 0, 0, 0, 0]
#yer2 = [0, 0, 0, 0, 0, 0, 0, 0]
#yer3 = [0, 0, 0, 0, 0, 0, 0, 0]
 
# The x position of bars
r1 = np.arange(len(bars1))
r2 = [x + barWidth for x in r1]
r3 = [x + barWidth for x in r2]

# Create blue bars
plt.bar(r1, bars1, width = barWidth, color = 'gray', edgecolor = 'black', hatch="/////", capsize=7, label='Nativo')

# Create red bars
plt.bar(r2, bars2, width = barWidth, color = 'red', edgecolor = 'black', hatch="-----", capsize=7, label='KVM')

# Create green bars
plt.bar(r3, bars3, width = barWidth, color = 'blue', edgecolor = 'black', hatch="|||||", capsize=7, label='ESXi')
 
# general layout
plt.xticks([r + barWidth for r in range(listTam)], listaBenchmarks)
plt.ylabel('Time in seconds (Lower is better)')
plt.xlabel('Benchmarks')
plt.title('Tempo Medio\n Classe: '+classe+' Numero de nos: '+processos)
plt.legend(loc='upper left')

plt.gca().yaxis.grid(True, linestyle='--')

# Show graphic
#plt.show()

# Save as pdf

plt.savefig("Experimento-"+exp+"-cores-"+processos+".pdf") 
