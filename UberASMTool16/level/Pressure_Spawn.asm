macro call_library(i)
	PHB
	LDA.b #<i>>>16
	PHA
	PLB
	JSL <i>
	PLB
endmacro


init:
;%call_library(NoInteract_init)
;%call_library(StartOffState_init)
RTL

main:
%call_library(PressuredWater_main)
;%call_library(lrspawncarried_main)
%call_library(LRSpawnCarried_main)
RTL