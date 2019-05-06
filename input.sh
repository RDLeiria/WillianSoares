#!/bin/bash

if [ $# -lt 1 ]; then
   echo "Faltou utilizar pelo menos um argumento!"
   exit 1
fi 

indexProcess=$1 # Recebe o indice zero para executar os processos

if [[ $indexProcess -eq 7 ]]; then
	exit 1
fi

# Define a classe do problema
classe=S repeticoes=1 ambiente=Nativo
listProcess=(1 2 4 8 9 16 32) 
processos=${listProcess[${indexProcess}]}
./script.sh $classe $processos $repeticoes $ambiente $indexProcess
