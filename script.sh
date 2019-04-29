#!/bin/bash

# Argumentos recebidos da funcao input

echo "To no script.sh"
if [ $# -lt 3 ]; then
   echo "Faltou utilizar pelo menos um argumento!"
   exit 1
fi 
#echo "Numero de argumentos: $#"
classe=$1
nprocessos=$2
repeticoes=$3

# Imprime a classe e a quantidade de processos definidas
#echo $classe $nprocessos

Compile()
{
	cd NPB3.3.1/NPB3.3-MPI/ # Caminha ate o diretorio
	cp config/suite.def.template config/suite.def # Faz uma copia suite.def
	cp config/make.def.template config/make.def # Faz uma copia make.def
	
	# Muda o compilador f77 para o mpif77 e o cc para o mpicc
	sed -i -e 's/\<f77\>/mpif77/g' -e 's/\<cc\>/mpicc/g' config/make.def 
	# Define a classe dos benchmarks e os processos de acordo com o arquivo input.sh
	sed -i -e "s/\<[A-Z]\>/$classe/g" config/suite.def 
	sed -i -e "s/\<[0-9]\>/$nprocessos/g" config/suite.def 

	make suite #Compila os benchmarks
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
	echo $kernel

	for i in `seq 1 $repeticoes` #Executa o mesmo benchmark de 1 até n
			do
			#Executa o benchmark e guarda no diretorio Resultado
				~/WillianSoares/NPB3.3.1/NPB3.3-MPI/bin/$kernel.$classe.$nprocessos >> ~/WillianSoares/Resultado/$kernel.$classe.$nprocessos.out 
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
	cd ~/WillianSoares/Resultado

	# Cria o arquivo csv
	echo "timeExec, class, mops, benchmark, nNos, nCores" > $kernel.$classe.$nprocessos.csv #cabecalho do arquivo
	#echo "$(Parser);;$kernel;;" >> $kernel.S.csv 
	echo "$(Parser)" >> $kernel.$classe.$nprocessos.csv 
	#Guarda no arquivo csv apenas o tempo em segundo das execucoes	
	#Parser >> $kernel.S.csv 
}

Parser()
{
	grep "Time in seconds" $kernel.$classe.$nprocessos.out | sed 's/ //g' | cut -d "=" -f2
}

CallPython()
{
	cd ~/WillianSoares
	python pyscript.py $classe $nprocessos	#Cria os graficos de barras e salva como pdf
	# python linegraphs.py 	#Cria os graficos estilo linha e salva como pdf
}

### Inicio da execucao das funcoes ###
 Compile			# Compila os arquivos 
# RunBenchmarks		# Executa todos os 8 benchmarks, gera os arquivos ".out"
# RunParsing			# Realiza o parsing dos dados obtidos das execucoes, gera os arquivos ".csv"
# CallPython			# Calcula a media do tempo de execucoes dos benchmarks e cria os graficos
