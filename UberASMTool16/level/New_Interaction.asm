macro call_library(i)
	PHB
	LDA.b #<i>>>16
	PHA
	PLB
	JSL <i>
	PLB
endmacro


init:
%call_library(NoInteract_init)
%call_library(StartOffState_init)
RTL

main:
%call_library(NoInteract_main)
%call_library(SpritePaletteSet_main)
RTL