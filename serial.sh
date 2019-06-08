#!/bin/bash

classe=B
repeticoes=20

Directories()
{
	mkdir resultados/ExperimentoSerial
	mkdir resultados/ExperimentoSerial/SerialResultado	
}

ChooseBenchmakrs()
{
	listOfBenchmarks=(is ep cg mg ft bt sp lu)
}

Compile() # Compila os benchmarks de acordo com o arquivo de input.sh
{
	cd NPB3.3.1/NPB3.3-SER/ 			 # Caminha ate o diretorio
	cp config/suite.def.template config/suite.def	 # Faz uma copia suite.def
	cp config/make.def.template config/make.def 	 # Faz uma copia make.def
	
	# Define a classe dos benchmarks e os processos de acordo com o arquivo input.sh
	sed -i -e "s/\<[A-Z]\>/$classe/g" config/suite.def 
		
	make suite #Compila os benchmarks
}

RunBenchmarks() # Executa os benchmarks 
{
	ARRAY=("${listOfBenchmarks[@]}")
	for i in `seq 0 7` #laco de repeticao para executar todos os benchmarks do array
		do
			Executa ${ARRAY[$i]}
		done
}

Executa()
{	
	kernel=$1 # Recebe como parametro o kernel que sera executado
	cd ~/WillianSoares/NPB3.3.1/NPB3.3-SER/bin

	# Executa o benchmark em uma VM ou no ambiente nativo
	for i in `seq 1 $repeticoes` #Executa o mesmo benchmark de 1 até n
		do
			# Executa o benchmark e guarda no diretorio Resultado
		 	./$kernel.$classe.x >> ~/WillianSoares/resultados/ExperimentoSerial/SerialResultado/Serial.$kernel.$classe.x.txt 
		done
}

RunParsing() 
{
	ARRAY=("${listOfBenchmarks[@]}")
	for i in `seq 0 7` #laco de repeticao para realizar o parsing dos dados
		do
			Parsing ${ARRAY[$i]}
		done
}

Parsing()
{
	kernel=$1 #O kernel que sera executado
	cd ~/WillianSoares/resultados/ExperimentoSerial/

	# Cria o arquivo csv
	echo "timeExec" > SerialResultado/Serial.$kernel.$classe.x.csv # cabecalho do arquivo
	echo "$(Parser)" >> SerialResultado/Serial.$kernel.$classe.x.csv 
}

Parser()
{
	cd ~/WillianSoares/resultados/ExperimentoSerial/SerialResultado
	grep "Time in seconds" Serial.$kernel.$classe.x.txt | sed 's/ //g' | cut -d "=" -f2
}

### Inicio da execucao das funcoes ###
 Directories		# Cria o diretorio para o resultado da versão Serial
 ChooseBenchmakrs	# Escolhe os benchmarks baseado no numero de nodos
 Compile		# Compila os arquivos 
 RunBenchmarks		# Executa todos os 8 benchmarks, gera os arquivos ".txt"
 RunParsing 		# Realiza o parsing dos dados obtidos das execucoes, gera os arquivos ".csv"
 

