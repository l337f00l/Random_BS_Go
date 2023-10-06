macro call_library(i)
	PHB
	LDA.b #<i>>>16
	PHA
	PLB
	JSL <i>
	PLB
endmacro


init:
%call_library(PSwitchMeter_init)
;%call_library(noground_init)
RTL

main:
%call_library(PSwitchMeter_main)
%call_library(noground_main)
RTL