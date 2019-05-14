#!/bin/bash

BarGraphsCreate()
{
	python pyscript.py B 1 1 # classe, num de nodes, experimento
}

LineGraphsCreate()
{
	python linegraphs.py S is
	python linegraphs.py S ep
	python linegraphs.py S cg
	python linegraphs.py S mg
	python linegraphs.py S ft
	python linegraphs.py S bt
	python linegraphs.py S sp
	python linegraphs.py S lu
}

BarGraphsCreate
#LineGraphsCreate