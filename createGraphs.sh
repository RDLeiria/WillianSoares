#!/bin/bash

BarGraphsCreate()
{
	: '
	# Uma VM
	python pyscript.py B 1 1 # classe, num de cores por vm, experimento
	python pyscript.py B 1 2 

	python pyscript.py B 2 3 
	python pyscript.py B 2 4 
	
	python pyscript.py B 3 5 
	python pyscript.py B 3 6
		
	python pyscript.py B 4 7 
	python pyscript.py B 4 8
	
	python pyscript.py B 5 9
	python pyscript.py B 5 10

	python pyscript.py B 6 11
	python pyscript.py B 6 12
	'
	# 2 VMs, nesse caso, o arquivo que gera os graficos deve ser modificado
	#python pyscript.py B 1 13
	#python pyscript.py B 2 14
	#python pyscript.py B 4 15

}

LineGraphsCreate()
{
	python linegraphs.py B  is
	#python linegraphs.py S ep
	#python linegraphs.py S cg
	#python linegraphs.py S mg
	#python linegraphs.py S ft
	#python linegraphs.py S bt
	#python linegraphs.py S sp
	#python linegraphs.py S lu
}

#BarGraphsCreate
LineGraphsCreate
