#!/bin/bash

BarGraphsCreate()
{
	python pyscript.py S 1
	python pyscript.py S 2
	python pyscript.py S 4
	python pyscript.py S 8
	python pyscript.py S 9
	python pyscript.py S 16
}

LineGraphsCreate()
{
#	python linegraphs.py S is
#	python linegraphs.py S ep
#	python linegraphs.py S cg
#	python linegraphs.py S mg
#	python linegraphs.py S ft
#	python linegraphs.py S bt
#	python linegraphs.py S sp
	python linegraphs.py S lu
}

#BarGraphsCreate
LineGraphsCreate