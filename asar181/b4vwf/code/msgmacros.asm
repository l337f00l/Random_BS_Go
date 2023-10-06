macro u(n)
	if (<n>) < 0 || (<n>) >= $200000
		error "Invalid unicode %u(<n>): <n> is not a unicode codepoint"
	elseif (<n>) < $0080
		db (<n>)
	elseif <n> < $0800
		db ($c0|(((<n>)>>6)&$1f)), ($80|((<n>)&$3f))
	elseif (<n>) >= $d800 && (<n>) < $e000
		error "Invalid unicode %u(<n>): surrogates (D800...DFFF) are unsupported"
	elseif (<n>) >= $e100 && (<n>) < $f900
		error "Invalid unicode %u(<n>): private use characters U+E100...U+F8FF are unsupported"
	elseif (<n>) < $010000
		db ($e0|(((<n>)>>12)&$0f)), ($80|(((<n>)>>6)&$3f)), ($80|((<n>)&$3f))
	elseif (<n>) < $200000
		error "Invalid unicode %u(<n>): astral plane characters (U+01_0000...) are unsupported"
	endif
endmacro

macro heading()
	db $01
endmacro

macro headend()
	db $02
endmacro

macro font(id)
	if <id> >= $40
		error "bad %font: font number must be less than $40"
	endif
	db $1b, "F", $40|(<id>)
endmacro

macro palette(color)
	if <color>&$e3 != $60
		error "bad %palette: must start at color $60, $64, $68, $6c, $70, $74, $78, or $7c"
	endif
	db $1b, "P", <color>
endmacro

macro screenexit(arg)
	if <arg>&~$1f
		"bad argument to %screenexit (there's only $1f screens)"
	endif
	db $1b, "E", $40|<arg>
endmacro

macro exitlevel(arg)
	if <arg>&~$f
		error "bad argument to %endlevel()"
	endif
	db $1b, "S", $30|<arg>
endmacro

macro setheight(n)
	if <n> < 1 || <n> >= 33
		error "bad %setheight: height must be in range 1...33"
	endif
	db $1b, "H", $40|(<n>&$3f)
endmacro

macro setposy(y)
	if <y> < 1 || <y> > 216
		error "bad y pos for %setposy(<y>): must be in the range 1...216"
	endif
	db $1b, "Y"
	%u(<y>+$20)
endmacro
