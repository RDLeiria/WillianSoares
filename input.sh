#!/bin/bash

Download() # Realiza o download NPB
{
	mkdir Resultado #Cria um diretorio para os resultados dos benchmarks
	mkdir Graficos #Cria um diretorio para os graficos
	wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz #Download do NPB
	tar -xf NPB3.3.1.tar.gz #Descompactar NPB
}

#Download # Realiza o download do NPB3.3.1

# Define a classe do problema
classe=B processos=1 repeticoes=1
exec ./script.sh $classe $processos $repeticoes

#ARRAY=(1)
#for i in `seq 0 2` #laco de repeticao para executar todos os benchmarks do array
#	do
#		classe=S 
#		processos=${ARRAY[$i]}
#		repeticoes=2
#		exec ./script.sh $classe $processos $repeticoes 
#done

echo "fim"