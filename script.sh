#!/bin/bash

Download()
{
	mkdir Resultado #Cria um diretorio para os resultados dos benchmarks
	wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz #Download do NPB
	tar -xf NPB3.3.1.tar.gz #Descompactar NPB
}

Compila()
{
	cd NPB3.3.1/NPB3.3-SER/ #Caminha ate o diretorio
	cp config/suite.def.template config/suite.def #Faz uma copia suite.def
	cp config/make.def.template config/make.def #Faz uma copia make.def
	make suite #Compila os benchmarks
}

Executa()
{
	kernel=$1 #O kernel que sera executado

	for i in `seq 1 2` #laco de repeticao para executar todos os benchmarks do array
		do
			#Executa o benchmark e guarda no diretorio Resultado
			~/MeuScript/WillianSoares/NPB3.3.1/NPB3.3-SER/bin/$kernel.S.x >> ~/MeuScript/WillianSoares/Resultado/$kernel.S.out 
		done
}

Parsing()
{
	kernel=$1 #O kernel que sera executado
	cd ~/MeuScript/WillianSoares/Resultado
	#empo= Parser
	echo "timeExec, class, mops, benchmark, nNos, nCores" > $kernel.S.csv #cabecalho do arquivo
	#echo "$(Parser);;$kernel;;" >> $kernel.S.csv 
	echo "$(Parser)" >> $kernel.S.csv 
	#Guarda no arquivo csv apenas o tempo em segundo das execucoes	
	#Parser >> $kernel.S.csv 
}

Parser()
{
	grep "Time in seconds" $kernel.S.out | sed 's/ //g' | cut -d "=" -f2
}


Benchmarks()
{
	ARRAY=(bt is ft)
	len=${#ARRAY[@]} #retorna a quantidade de elementos no array

	for i in `seq 0 2` #laco de repeticao para executar todos os benchmarks do array
		do
			Executa ${ARRAY[$i]}
		done

	for i in `seq 0 2` #laco de repeticao para realizar o parsing dos dados
		do
			Parsing ${ARRAY[$i]}
		done
}

Avarage()
{
	cd ~/MeuScript/WillianSoares
	python pyscript.py
}


### Inicio da execucao das funcoes ###

#Download
#Compila
Benchmarks
Avarage

#cd ~/MeuScript/
#python pyscript.py

#tentar executar a versao serial