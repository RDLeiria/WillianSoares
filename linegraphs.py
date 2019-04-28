#--------------------Criacao dos graficos de linha ---------------------------

# -*- coding: utf-8 -*-
"""lineGraphs.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1eFk7wUmW1_OLNz8c7TDv8VYnKM3Am0NG
"""

#Reference https://python-graph-gallery.com/122-multiple-lines-chart/
#Reference: https://stackoverflow.com/questions/44813601/how-to-set-x-axis-values-in-matplotlib-python

import numpy as np
import matplotlib.pyplot as plt

x = [1, 2, 8, 16]

# create an index for each tick position
xi = [i for i in range(0, len(x))]
y1 = [300, 100, 50, 20]
y2 = [280, 80, 45, 15]
y3 = [250, 70, 40, 13]

#plt.ylim(0.8,1.4)

# plot the index for the x-values
plt.plot(xi, y1, marker='o', linestyle='-', color='r', label='KVM') 
plt.plot(xi, y2, marker='x', linestyle='--', color='b', label='ESXi') 
plt.plot(xi, y3, marker='*', linestyle='--', color='g', label='Nativo') 

plt.xlabel('Processadores')
plt.ylabel('Tempo (S)') 
plt.xticks(xi, x)
plt.title('(A) NPB-MPI-BT (Tempo Medio)')
plt.legend()
plt.grid()

# Show graph
#plt.show()

# Save as pdf
plt.savefig("Graficos/lineGraph.pdf")