macro call_library(i)
	PHB
	LDA.b #<i>>>16
	PHA
	PLB
	JSL <i>
	PLB
endmacro


init:
%call_library(NoPoints_init)
%call_library(Roll_init)
%call_library(BigMario_init)
RTL

main:
%call_library(NoPoints_main)
%call_library(Roll_main)
RTL