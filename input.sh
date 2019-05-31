#!/bin/bash
# Classe do benchmakrs
class=B 

# Quantidade total de cores
cores=2 

# Quantidade de nos utilizados
nodes=2

# Numero total de repeticoes para cada benchmark
repeticoes=20 

# Ambienete dos experimentos
ambiente=ESXi 

# Quantidade mem ram utilizada
ram=4 

# Tamanho do hd utilizado
disc=32	

# Identificacao do experimento
exp=13 

./script.sh $class $cores $repeticoes $ambiente $ram $disc $exp $nodes
