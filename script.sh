#!/bin/bash

# Argumentos recebidos da funcao input
echo "To no script.sh"
if [ $# -lt 9 ]; then
   echo "Faltou utilizar pelo menos 8 argumentos!"
   exit 1
fi 

classe=$1	# Classe dos benchmarks
nprocessos=$2	# Quantidade de processos
repeticoes=$3 	# Total de repeticoes para cada benchmark
ambiente=$4	# Label para identificar o ambiente dos experimentos
ram=$5		# Quantidade de mem ram utilizada no experimento
disc=$6		# Quantidade tamanho do HD utilizado no experimento
exp=$7		# Identificacao do experimento
cpuTotal=$8	# Quantidade total de cpus utilizadas
numVms=$9	# Quantidade de VMs nos experimentos

Directories()
{	
	# Cria um diretorio para os resultados dos benchmarks
	if [[ ! -d "Experimento${exp}" ]]; then
		mkdir resultados/Experimento${exp}
	fi	

	# Cria um diretorio para os resultados dos benchmarks
	if [[ ! -d "${ambiente}Resultado" ]]; then
		mkdir resultados/Experimento${exp}/${ambiente}Resultado
	fi	
	
	# Cria um diretorio para os graficos
	if [[ ! -d "Graficos" ]]; then
		mkdir Graficos 
	fi
}

Download() # Realiza o download NPB
{
	if [[ ! -d "NPB3.3.1" ]]; then
		# Download do NPB
		wget https://www.nas.nasa.gov/assets/npb/NPB3.3.1.tar.gz
		# Descompacta o NPB
		tar -xf NPB3.3.1.tar.gz
	fi
}

ChooseBenchmakrs()
{
	listOfBenchmarks=(is ep cg mg ft bt sp lu)
}

Compile() # Compila os benchmarks de acordo com o arquivo de input.sh
{
	cd NPB3.3.1/NPB3.3-MPI/ 			 # Caminha ate o diretorio
	cp config/suite.def.template config/suite.def	 # Faz uma copia suite.def
	cp config/make.def.template config/make.def 	 # Faz uma copia make.def
	
	# Muda o compilador f77 para o mpif77 e o cc para o mpicc
	sed -i -e 's/\<f77\>/mpif77/g' -e 's/\<cc\>/mpicc/g' config/make.def 
	
	# Define a classe dos benchmarks e os processos de acordo com o arquivo input.sh
	sed -i -e "s/\<[A-Z]\>/$classe/g" config/suite.def 
	sed -i -e "s/\<[0-9]\>/$nprocessos/g" config/suite.def 
	
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
	cd ~/WillianSoares/NPB3.3.1/NPB3.3-MPI/bin

	# Executa o benchmark em uma VM ou no ambiente nativo
	if [[ numVms -le 1 ]]; then 
		for i in `seq 1 $repeticoes` #Executa o mesmo benchmark de 1 até n
				do
					#Executa o benchmark e guarda no diretorio Resultado
				 	mpirun -np $nprocessos ./$kernel.$classe.$nprocessos >> ~/WillianSoares/resultados/Experimento${exp}/${ambiente}Resultado/$ambiente.$kernel.$classe.$nprocessos.txt 
				done
	fi

	# Executa o benchmark em multiplas VMs
	if [[ numVms -gt 1 ]]; then
        for i in `seq 1 $repeticoes` #Executa o mesmo benchmark de 1 até n
    			do
                	#Executa o benchmark e guarda no diretorio Resultado
 	                mpirun --machinefile /home/willian/WillianSoares/host.txt -np $cpuTotal ./$kernel.$classe.$nprocessos >> ~/WillianSoares/resultados/Experimento${exp}/${ambiente}Resultado/$ambiente.$kernel.$classe.$nprocessos.txt
                    #mpirun --machinefile /home/willian/WillianSoares/host.txt -np $nprocessos ./$kernel.$clas$
                done
	fi
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
	cd ~/WillianSoares/resultados/Experimento${exp}/

	# Cria o arquivo csv
	echo "timeExec, class, mops, benchmark, nNos, nCores" > ${ambiente}Resultado/$ambiente.$kernel.$classe.$nprocessos.csv 	 		# cabecalho do arquivo
	echo "$(Parser)" >> ${ambiente}Resultado/$ambiente.$kernel.$classe.$nprocessos.csv 
}

Parser()
{
	cd ~/WillianSoares/resultados/Experimento${exp}/${ambiente}Resultado
	grep "Time in seconds" $ambiente.$kernel.$classe.$nprocessos.txt | sed 's/ //g' | cut -d "=" -f2
}

### Inicio da execucao das funcoes ###
 Directories 		# Cria os diretorios para os graficos e resultados
 Download 		# Realiza o download do NPB
 ChooseBenchmakrs	# Escolhe os benchmarks baseado no numero de nodos
 Compile		# Compila os arquivos 
 RunBenchmarks		# Executa todos os 8 benchmarks, gera os arquivos ".txt"
 RunParsing 		# Realiza o parsing dos dados obtidos das execucoes, gera os arquivos ".csv"
