#!/bin/bash

# Argumentos recebidos da funcao input

echo "To no script.sh"
if [ $# -lt 5 ]; then
   echo "Faltou utilizar pelo menos 5 argumentos!"
   exit 1
fi 

classe=$1		# Classe dos benchmarks
nprocessos=$2	# Quantidade de processos
repeticoes=$3 	# Total de repeticoes para cada benchmark
ambiente=$4		# Label para identificar o ambiente dos experimentos
indice=$5		# Indice do arquivo input.sh

# Imprime a classe e a quantidade de processos definidas
#echo $classe $nprocessos

Directories()
{
	if [[ ! -d "${ambiente}Resultado" ]]; then
		mkdir ${ambiente}Resultado #Cria um diretorio para os resultados dos benchmarks
	fi	
	#mkdir ${ambiente}Graficos #Cria um diretorio para os graficos
}

Download() # Realiza o download NPB
{
	if [[ ! -d "NPB3.3.1" ]]; then
		wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz #Download do NPB
		tar -xf NPB3.3.1.tar.gz #Descompactar NPB
	fi
}

Compile() # Compila os benchmarks de acordo com o arquivo de input.sh
{
	cd NPB3.3.1/NPB3.3-MPI/ # Caminha ate o diretorio
	cp config/suite.def.template config/suite.def # Faz uma copia suite.def
	cp config/make.def.template config/make.def # Faz uma copia make.def
	
	# Muda o compilador f77 para o mpif77 e o cc para o mpicc
	sed -i -e 's/\<f77\>/mpif77/g' -e 's/\<cc\>/mpicc/g' config/make.def 
	
	# Define a classe dos benchmarks e os processos de acordo com o arquivo input.sh
	sed -i -e "s/\<[A-Z]\>/$classe/g" config/suite.def 
	sed -i -e "s/\<[0-9]\>/$nprocessos/g" config/suite.def 
	
	make is CLASS=$classe NPROCS=$nprocessos
	make ep CLASS=$classe NPROCS=$nprocessos
	make cg CLASS=$classe NPROCS=$nprocessos
	make mg CLASS=$classe NPROCS=$nprocessos	
	make ft CLASS=$classe NPROCS=$nprocessos
	make bt CLASS=$classe NPROCS=$nprocessos
	make sp CLASS=$classe NPROCS=$nprocessos
	make lu CLASS=$classe NPROCS=$nprocessos

	#make suite #Compila os benchmarks
}

RunBenchmarks() 
{
	#echo "RunBenchmarks"
	ARRAY=(is ep cg mg ft bt sp lu)
	#len=${#ARRAY[@]} #retorna a quantidade de elementos no array
	for i in `seq 0 7` #laco de repeticao para executar todos os benchmarks do array
		do
			Executa ${ARRAY[$i]}
	done
}

Executa()
{	
	kernel=$1 #O kernel que sera executado
	cd ~/WillianSoares/NPB3.3.1/NPB3.3-MPI/bin
	#echo $(pwd)
	echo $kernel

	for i in `seq 1 $repeticoes` #Executa o mesmo benchmark de 1 até n
			do
			#Executa o benchmark e guarda no diretorio Resultado
			 	#cd /WillianSoares/NPB3.3.1/NPB3.3-MPI/bin
			 	mpirun -np $nprocessos $kernel.$classe.$nprocessos >> ~/WillianSoares/${ambiente}Resultado/$ambiente.$kernel.$classe.$nprocessos.out 
			 	#exec mpirun -np $nprocessos $($kernel.$classe.$nprocessos) >> ~/WillianSoares/Resultado/$kernel.$classe.$nprocessos.out 
			done
}

RunParsing()
{
	ARRAY=(is ep cg mg ft bt sp lu)
	#len=${#ARRAY[@]} #retorna a quantidade de elementos no array
	for i in `seq 0 7` #laco de repeticao para realizar o parsing dos dados
		do
			Parsing ${ARRAY[$i]}
		done
}

Parsing()
{
	kernel=$1 #O kernel que sera executado
	cd ~/WillianSoares/${ambiente}Resultado

	# Cria o arquivo csv
	echo "timeExec, class, mops, benchmark, nNos, nCores" > $ambiente.$kernel.$classe.$nprocessos.csv #cabecalho do arquivo
	#echo "$(Parser);;$kernel;;" >> $kernel.S.csv 
	echo "$(Parser)" >> $ambiente.$kernel.$classe.$nprocessos.csv 
	#Guarda no arquivo csv apenas o tempo em segundo das execucoes	
	#Parser >> $kernel.S.csv 
}

Parser()
{
	grep "Time in seconds" $ambiente.$kernel.$classe.$nprocessos.out | sed 's/ //g' | cut -d "=" -f2
}

CallPython()
{
	cd ~/WillianSoares
	python pyscript.py $classe $nprocessos	#Cria os graficos de barras e salva como pdf
	python linegraphs.py $indice			#Cria os graficos estilo linha e salva como pdf
}

NextNumNos() # Executa o script novamente para o proximo num de nos definido na lista do arquivo input.sh
{
	cd ~/WillianSoares

	indice="$((indice +1))"
	./input.sh $indice	
}

### Inicio da execucao das funcoes ###
 Directories 		# Cria os diretorios para os graficos e resultados
 Download 			# Realiza o download do NPB
 #Compile			# Compila os arquivos 
 #RunBenchmarks		# Executa todos os 8 benchmarks, gera os arquivos ".out"
 #RunParsing 		# Realiza o parsing dos dados obtidos das execucoes, gera os arquivos ".csv"
 #CallPython		# Calcula a media do tempo de execucoes dos benchmarks e cria os graficos
 #NextNumNos			
