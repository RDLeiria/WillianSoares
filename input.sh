#!/bin/bash
# Classe do benchmakrs
class=B 

# Quantidade de cores por vm
cores=2 

# Quantidade  total de cores de todas vms
cpuTotal=4

# Informa se eh mais de uma vm
numVms=2

# Numero total de repeticoes para cada benchmark
repeticoes=20 

# Ambienete dos experimentos
ambiente=ESXi 

# Quantidade mem ram utilizada
ram=4 

# Tamanho do hd utilizado
disc=32	

# Identificacao do experimento
exp=42

./script.sh $class $cores $repeticoes $ambiente $ram $disc $exp $cpuTotal $numVms
