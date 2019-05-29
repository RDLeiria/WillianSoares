#!/bin/bash
# Classe do benchmakrs
class=B 

# Quantidade de cores por vm
cores=2 

# Quantidade de nos utilizados
nodes=0

# Numero total de repeticoes para cada benchmark
repeticoes=20 

# Ambienete dos experimentos
ambiente=Nativo 

# Quantidade mem ram utilizada
ram=4 

# Tamanho do hd utilizado
disc=32	

# Identificacao do experimento
exp=42 

./script.sh $class $cores $repeticoes $ambiente $ram $disc $exp $nodes



