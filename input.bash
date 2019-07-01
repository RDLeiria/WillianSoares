#!/bin/bash
# Classe do benchmakrs
class=B

# Quantidade de cores por vm
cores=3 

# Quantidade  total de cores de todas vms
cpuTotal=3

# Informa se eh mais de uma vm
numVms=1

# Numero total de repeticoes para cada benchmark
repeticoes=20 

# Ambiente dos experimentos
ambiente=Nativo 

# Quantidade mem ram utilizada
ram=4 

# Tamanho do hd utilizado
disc=32	

# Identificacao do experimento
exp=20

./script.sh $class $cores $repeticoes $ambiente $ram $disc $exp $cpuTotal $numVms
