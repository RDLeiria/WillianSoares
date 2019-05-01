#!/bin/bash

if [ $# -lt 1 ]; then
   echo "Faltou utilizar pelo menos um argumento!"
   exit 1
fi 

indexProcess=$1 # Recebe o indice zero para executar os processos


Download() # Realiza o download NPB
{
	mkdir Resultado #Cria um diretorio para os resultados dos benchmarks
	mkdir Graficos #Cria um diretorio para os graficos
	wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz #Download do NPB
	tar -xf NPB3.3.1.tar.gz #Descompactar NPB
}

#Download # Realiza o download do NPB3.3.1

# Define a classe do problema
classe=S repeticoes=2
listProcess=(1 2 4 8 9 16) 
processos=${listProcess[${indexProcess}]}
exec ./script.sh $classe $processos $repeticoes $indexProcess

#ARRAY=(1)
#for i in `seq 0 2` #laco de repeticao para executar todos os benchmarks do array
#	do
#		classe=S 
#		processos=${ARRAY[$i]}
#		repeticoes=2
#		exec ./script.sh $classe $processos $repeticoes 
#done