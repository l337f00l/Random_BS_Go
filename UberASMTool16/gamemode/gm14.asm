macro call_library(i)
	PHB
	LDA.b #<i>>>16
	PHA
	PLB
	JSL <i>
	PLB
endmacro

init:                 
%call_library(AllowFramePerfectSpinflyReflight_init)
RTL

main:
jsl retry_in_level_main
JSL ScreenScrollingPipes_SSPMaincode
%call_library(OnOffDoubleHitCooldown_main)
%call_library(PowerupNoFreeze_main)
%call_library(DisableLRScrolling_main)
%call_library(AllowFramePerfectSpinflyReflight_main)
RTL

nmi:
jsl retry_nmi_level
rtl