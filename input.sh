#!/bin/bash
classe=S 		#classe do programa
nodes=1			#quantidade de nodes ativos
repeticoes=1	#numero total de repeticoes para cada benchmark
ambiente=KVM 	#ambienete dos experimentos
ram=4 			#quantidade mem ram utilizada
disc=32			#tamanho do hd utilizado
exp=22			#identificacao do experimento

./script.sh $classe $nodes $repeticoes $ambiente $ram $disc $exp



