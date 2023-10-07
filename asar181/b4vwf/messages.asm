lvl000_1:
	db "", $00
lvl000_2:
	db "", $00
lvl001_1:
	db "", $00
lvl001_2:
	db "", $00
lvl002_1:
	db "", $00
lvl002_2:
	db "", $00
lvl003_1:
	db "", $00
lvl003_2:
	db "", $00
lvl004_1:
	db "", $00
lvl004_2:
	db "", $00
lvl005_1:
	db "The level starts in the off postion and", $0a
	db "blue shells won't interact with Mario when the", $0a
	db "On/Off is in the Off position.", $0c
	db "Also touch the green shell to teleport to the level", $0a
	db "Good Luck Have Fun - L337", $00
lvl005_2:
	db "", $00
lvl006_1:
	db "", $00
lvl006_2:
	db "", $00
lvl007_1:
	db "", $00
lvl007_2:
	db "The P-Switches activate the ground in this level", $00
lvl008_1:
	%exitlevel($04) ; green switch palace
	; use colors $78-$7b of the level palette for this message
	%palette($78)
	%font($02)
	db "SWITCH PALACE", $0a
	%font($01)
	db "The power of the switch you have", $0a
	db "pushed will turn " : %u($e001) : db " into " : %u($e002) : db ".", $0a
	db "Your progress will also be saved.", $00

lvl008_2:
	db "", $00
lvl009_1:
	db "", $00
lvl009_2:
	db "", $00
lvl00a_1:
	db "", $00
lvl00a_2:
	db "", $00
lvl00b_1:
	db "", $00
lvl00b_2:
	db "", $00
lvl00c_1:
	db "", $00
lvl00c_2:
	db "", $00
lvl00d_1:
	db "", $00
lvl00d_2:
	db "", $00
lvl00e_1:
	db "", $00
lvl00e_2:
	db "", $00
lvl00f_1:
	db "", $00
lvl00f_2:
	db "", $00
lvl010_1:
	db "These platforms transfer the speed into Mario", $0a 
	db "also free midairs, you can slow down with right or left", $00
lvl010_2:
	db "", $00
lvl011_1:
	db "", $00
lvl011_2:
	db "", $00
lvl012_1:
	db "GGs, now dump yoshi to win the level", $00
lvl012_2:
	db "", $00
lvl013_1:
	db "You need to hold an item when the nets are", $0a
	db "red, when they are blue you are safe.", $0c
	db "Touching this block will start Mario autorunning", $0a
	db "good luck", $00
lvl013_2:
	db "", $00
lvl014_1:
	%exitlevel($01) ; yellow switch palace
	; use colors $78-$7b of the level palette for this message
	%palette($78)
	%font($02)
	db "SWITCH PALACE", $0a
	%font($01)
	db "The power of the switch you have", $0a
	db "pushed will turn " : %u($e001) : db " into " : %u($e002) : db ".", $0a
	db "Your progress will also be saved.", $00
lvl014_2:
	db "", $00
lvl015_1:
	db "", $00
lvl015_2:
	db "", $00
lvl016_1:
	db "", $00
lvl016_2:
	db "", $00
lvl017_1:
	db "", $00
lvl017_2:
	db "", $00
lvl018_1:
	db "", $00
lvl018_2:
	db "", $00
lvl019_1:
	db "", $00
lvl019_2:
	db "", $00
lvl01a_1:
	db "", $00
lvl01a_2:
	db "", $00
lvl01b_1:
	db "", $00
lvl01b_2:
	db "", $00
lvl01c_1:
	db "", $00
lvl01c_2:
	db "", $00
lvl01d_1:
	db "", $00
lvl01d_2:
	db "", $00
lvl01e_1:
	db "", $00
lvl01e_2:
	db "", $00
lvl01f_1:
	db "", $00
lvl01f_2:
	db "", $00
lvl020_1:
	db "", $00
lvl020_2:
	db "", $00
lvl021_1:
	db "", $00
lvl021_2:
	db "", $00
lvl022_1:
	db "I approve of this level - phantomofares", $0a
	db "This is all RZRiders fault, enjoy", $00
lvl022_2:
	db "You Guessed it Casio Water, you can spawn a", $0a 
	db "throwblock "
	db "with R and a shell with L however these ", $0a
	db "nets will hurt you "
	db "if you are holding any item, so GLHF", $00
lvl023_1:
	db "", $00
lvl023_2:
	db "", $00
lvl024_1:
	db "", $00
lvl024_2:
	db "", $00
lvl101_1:
	db "", $00
lvl101_2:
	db "", $00
lvl102_1:
	db "", $00
lvl102_2:
	db "", $00
lvl103_1:
	db "", $00
lvl103_2:
	db "", $00
lvl104_1:
	db "Hello! Sorry I'm not home, but I have", $0a
	db "gone to rescue my friends who were", $0a
	db "captured by Bowser.", $0a
	db "   - Yoshi " : %u($e000) : db $00

lvl104_2:
	db "", $00

lvl105_1:
	db "This is a line in the default font.", $0a
	%font($00)
	db "This is a line in font $00.", $0a
	%font($01)
	db "This is a line in font $01.", $0a
	%font($02)
	db "This is a line in font $02.", $0c

	%font($01)
	db "This is a new message box started by $0c."
	db "", $0c

	db "This is a lengthy run-on sentence without any newlines in it"
	db " to display the automatic line splitting that happens when"
	db " you don't use $0a or $0c to split up your messages."
	db " Please consider the use of manual word wrapping to keep your"
	db " messages looking neat because the programmer of this patch"
	db " was far too lazy to write proper word wrap.", $0c

	%screenexit($00)
	db "And now a screen exit bc I need", $0a
	db "an example of that too", $00

lvl105_2:
	%heading()
		%setheight(8)
	%headend()
	%font($00)
	db "This message box has been enlarged", $0a
	db "to show what messages with headings look like.", $0a
	db "", $0a
	db "Note that large message boxes use more space in", $0a
	db "VRAM, and so may cause problems in certain levels.", $0a
	db "", $0a
	db "Now, enjoy some pangrams and character tests.", $0c

	%heading()
		%setposy(90)
	%headend()

	db "Woven Silk Pyjamas", $0a
	db "Exchanged For Blue Quartz", $0a
	db "", $0a
	db "SPHINX OF BLACK QUARTZ,", $0a
	db "HEAR MY VOW!", $0a
	db "", $0a
	db "pack my box with", $0a
	db "five dozen liquor jugs.", $0c

	db "• ‘forté’  em — dash  encyclopædia", $0a
	db "‣ ‹guillemets›  «×2»", $0a
	db "† 1÷2 = ½   ¡wow!   ¿huh?   e = mc²", $0a
	db "jalapeño … São Paulo … Nº 1 … Nª 1", $0a
	db "¡ ¢ £ ¤ ¥ ¦ § ¨ © ª « ¬ ® ¯", $0a
	db "ﾆﾎﾝｺﾞﾉｶﾀｶﾅ", $0a
	db "", $00

lvl106_1:
	db "", $00
lvl106_2:
	db "", $00
lvl107_1:
	db "", $00
lvl107_2:
	db "", $00
lvl108_1:
	db "These green blocks won't let Mario pass", $0a
	db "until you ditch Yoshi",$00
lvl108_2:
	db "Most levels have an explanation on what they ask of", $0a 
	db "the player, Start and Select to exit a level, every", $0a
	db "pipe and door transition is a midway and they save", $0a
	db " on the OW, Good Luck Have Fun - L337", $00
lvl109_1:
	db "", $00
lvl109_2:
	db "", $00
lvl10a_1:
	db "", $00
lvl10a_2:
	db "", $00
lvl10b_1:
	db "", $00
lvl10b_2:
	db "", $00
lvl10c_1:
	db "", $00
lvl10c_2:
	db "", $00
lvl10d_1:
	db "", $00
lvl10d_2:
	db "", $00
lvl10e_1:
	db "", $00
lvl10e_2:
	db "", $00
lvl10f_1:
	db "", $00
lvl10f_2:
	db "", $00
lvl110_1:
	db "", $00
lvl110_2:
	db "", $00
lvl111_1:
	db "Saws can be grabbed and the koopas like to kick ", $0A
	db "stuff in this level, GLHF", $00
lvl111_2:
	db "", $00
lvl112_1:
	db "", $00
lvl112_2:
	db "", $00
lvl113_1:
	db "", $00
lvl113_2:
	db "Collect the coin to get ammo for the shooter", $0A
	db "Use the R button, Shoot the shell into the sprite killer", $00
lvl114_1:
	db "", $00
lvl114_2:
	db "", $00
lvl115_1:
	db "", $00
lvl115_2:
	db "", $00
lvl116_1:
	db "", $00
lvl116_2:
	db "", $00
lvl117_1:
	db "", $00
lvl117_2:
	db "", $00
lvl118_1:
	db "", $00
lvl118_2:
	db "", $00
lvl119_1:
	db "", $00
lvl119_2:
	db "", $00
lvl11a_1:
	db "", $00
lvl11a_2:
	db "", $00
lvl11b_1:
	%exitlevel($03) ; red switch palace
	; use colors $78-$7b of the level palette for this message
	%palette($78)
	%font($02)
	db "SWITCH PALACE", $0a
	%font($01)
	db "The power of the switch you have", $0a
	db "pushed will turn " : %u($e001) : db " into " : %u($e002) : db ".", $0a
	db "Your progress will also be saved.", $00
lvl11b_2:
	db "", $00
lvl11c_1:
	db "", $00
lvl11c_2:
	db "", $00
lvl11d_1:
	db "", $00
lvl11d_2:
	db "", $00
lvl11e_1:
	db "", $00
lvl11e_2:
	db "", $00
lvl11f_1:
	db "", $00
lvl11f_2:
	db "", $00
lvl120_1:
	db "", $00
lvl120_2:
	db "", $00
lvl121_1:
	%exitlevel($02) ; blue switch palace
	; use colors $78-$7b of the level palette for this message
	%palette($78)
	%font($02)
	db "SWITCH PALACE", $0a
	%font($01)
	db "The power of the switch you have", $0a
	db "pushed will turn " : %u($e001) : db " into " : %u($e002) : db ".", $0a
	db "Your progress will also be saved.", $00
lvl121_2:
	db "", $00
lvl122_1:
	db "", $00
lvl122_2:
	db "", $00
lvl123_1:
	db "", $00
lvl123_2:
	db "", $00
lvl124_1:
	db "", $00
lvl124_2:
	db "", $00
lvl125_1:
	db "", $00
lvl125_2:
	db "", $00
lvl126_1:
	db "", $00
lvl126_2:
	db "", $00
lvl127_1:
	db "", $00
lvl127_2:
	db "", $00
lvl128_1:
	db "", $00
lvl128_2:
	db "", $00
lvl129_1:
	db "", $00
lvl129_2:
	db "", $00
lvl12a_1:
	db "", $00
lvl12a_2:
	db "", $00
lvl12b_1:
	db "", $00
lvl12b_2:
	db "", $00
lvl12c_1:
	db "", $00
lvl12c_2:
	db "", $00
lvl12d_1:
	db "", $00
lvl12d_2:
	db "", $00
lvl12e_1:
	db "", $00
lvl12e_2:
	db "", $00
lvl12f_1:
	db "", $00
lvl12f_2:
	db "", $00
lvl130_1:
	db "", $00
lvl130_2:
	db "", $00
lvl131_1:
	db "", $00
lvl131_2:
	db "", $00
lvl132_1:
	db "", $00
lvl132_2:
	db "", $00
lvl133_1:
	db "", $00
lvl133_2:
	db "", $00
lvl134_1:
	db "", $00
lvl134_2:
	db "", $00
lvl135_1:
	db "", $00
lvl135_2:
	db "", $00
lvl136_1:
	db "", $00
lvl136_2:
	db "", $00
lvl137_1:
	db "", $00
lvl137_2:
	db "", $00
lvl138_1:
	db "", $00
lvl138_2:
	db "", $00
lvl139_1:
	db "", $00
lvl139_2:
	db "", $00
lvl13a_1:
	db "", $00
lvl13a_2:
	db "", $00
lvl13b_1:
	db "", $00
lvl13b_2:
	db "", $00
; =============================================================================
msg001:
	%exitlevel($00)
	db "These are some random levels I had kicking around", $0a
	db "I apologize in advance, GLHF - L337", $00

msg002:
	; Message #2 of the intro level.
	; Not very useful...
	db "", $00

msg003:
	db "Hooray! Thank you for rescuing me.", $0a
	db "My name is Yoshi.", $0a
	db "On my way to rescue my friends,", $0a
	db "Bowser trapped me in that egg.", $00

msg004:
	db "", $00
msg005:
	db "", $00
msg006:
	db "", $00
msg007:
	db "", $00
msg008:
	db "", $00
msg009:
	db "", $00
msg00a:
	db "", $00
msg00b:
	db "", $00
msg00c:
	db "", $00
msg00d:
	db "", $00
msg00e:
	db "", $00
msg00f:
	db "", $00
msg010:
	db "", $00
msg011:
	db "", $00
msg012:
	db "", $00
msg013:
	db "", $00
msg014:
	db "", $00
msg015:
	db "", $00
msg016:
	db "", $00
msg017:
	db "", $00
msg018:
	db "", $00
msg019:
	db "", $00
msg01a:
	db "", $00
msg01b:
	db "", $00
msg01c:
	db "", $00
msg01d:
	db "", $00
msg01e:
	db "", $00
msg01f:
	db "", $00
msg020:
	db "", $00
msg021:
	db "", $00
msg022:
	db "", $00
msg023:
	db "", $00
msg024:
	db "", $00
msg025:
	db "", $00
msg026:
	db "", $00
msg027:
	db "", $00
msg028:
	db "", $00
msg029:
	db "", $00
msg02a:
	db "", $00
msg02b:
	db "", $00
msg02c:
	db "", $00
msg02d:
	db "", $00
msg02e:
	db "", $00
msg02f:
	db "", $00
msg030:
	db "", $00
msg031:
	db "", $00
msg032:
	db "", $00
msg033:
	db "", $00
msg034:
	db "", $00
msg035:
	db "", $00
msg036:
	db "", $00
msg037:
	db "", $00
msg038:
	db "", $00
msg039:
	db "", $00
msg03a:
	db "", $00
msg03b:
	db "", $00
msg03c:
	db "", $00
msg03d:
	db "", $00
msg03e:
	db "", $00
msg03f:
	db "", $00
msg040:
	db "", $00
msg041:
	db "", $00
msg042:
	db "", $00
msg043:
	db "", $00
msg044:
	db "", $00
msg045:
	db "", $00
msg046:
	db "", $00
msg047:
	db "", $00
msg048:
	db "", $00
msg049:
	db "", $00
msg04a:
	db "", $00
msg04b:
	db "", $00
msg04c:
	db "", $00
msg04d:
	db "", $00
msg04e:
	db "", $00
msg04f:
	db "", $00
msg050:
	db "", $00
msg051:
	db "", $00
msg052:
	db "", $00
msg053:
	db "", $00
msg054:
	db "", $00
msg055:
	db "", $00
msg056:
	db "", $00
msg057:
	db "", $00
msg058:
	db "", $00
msg059:
	db "", $00
msg05a:
	db "", $00
msg05b:
	db "", $00
msg05c:
	db "", $00
msg05d:
	db "", $00
msg05e:
	db "", $00
msg05f:
	db "", $00
msg060:
	db "", $00
msg061:
	db "", $00
msg062:
	db "", $00
msg063:
	db "", $00
msg064:
	db "", $00
msg065:
	db "", $00
msg066:
	db "", $00
msg067:
	db "", $00
msg068:
	db "", $00
msg069:
	db "", $00
msg06a:
	db "", $00
msg06b:
	db "", $00
msg06c:
	db "", $00
msg06d:
	db "", $00
msg06e:
	db "", $00
msg06f:
	db "", $00
msg070:
	db "", $00
msg071:
	db "", $00
msg072:
	db "", $00
msg073:
	db "", $00
msg074:
	db "", $00
msg075:
	db "", $00
msg076:
	db "", $00
msg077:
	db "", $00
msg078:
	db "", $00
msg079:
	db "", $00
msg07a:
	db "", $00
msg07b:
	db "", $00
msg07c:
	db "", $00
msg07d:
	db "", $00
msg07e:
	db "", $00
msg07f:
	db "", $00
msg080:
	db "", $00
msg081:
	db "", $00
msg082:
	db "", $00
msg083:
	db "", $00
msg084:
	db "", $00
msg085:
	db "", $00
msg086:
	db "", $00
msg087:
	db "", $00
msg088:
	db "", $00
msg089:
	db "", $00
msg08a:
	db "", $00
msg08b:
	db "", $00
msg08c:
	db "", $00
msg08d:
	db "", $00
msg08e:
	db "", $00
msg08f:
	db "", $00
msg090:
	db "", $00
msg091:
	db "", $00
msg092:
	db "", $00
msg093:
	db "", $00
msg094:
	db "", $00
msg095:
	db "", $00
msg096:
	db "", $00
msg097:
	db "", $00
msg098:
	db "", $00
msg099:
	db "", $00
msg09a:
	db "", $00
msg09b:
	db "", $00
msg09c:
	db "", $00
msg09d:
	db "", $00
msg09e:
	db "", $00
msg09f:
	db "", $00
msg0a0:
	db "", $00
msg0a1:
	db "", $00
msg0a2:
	db "", $00
msg0a3:
	db "", $00
msg0a4:
	db "", $00
msg0a5:
	db "", $00
msg0a6:
	db "", $00
msg0a7:
	db "", $00
msg0a8:
	db "", $00
msg0a9:
	db "", $00
msg0aa:
	db "", $00
msg0ab:
	db "", $00
msg0ac:
	db "", $00
msg0ad:
	db "", $00
msg0ae:
	db "", $00
msg0af:
	db "", $00
msg0b0:
	db "", $00
msg0b1:
	db "", $00
msg0b2:
	db "", $00
msg0b3:
	db "", $00
msg0b4:
	db "", $00
msg0b5:
	db "", $00
msg0b6:
	db "", $00
msg0b7:
	db "", $00
msg0b8:
	db "", $00
msg0b9:
	db "", $00
msg0ba:
	db "", $00
msg0bb:
	db "", $00
msg0bc:
	db "", $00
msg0bd:
	db "", $00
msg0be:
	db "", $00
msg0bf:
	db "", $00
msg0c0:
	db "", $00
msg0c1:
	db "", $00
msg0c2:
	db "", $00
msg0c3:
	db "", $00
msg0c4:
	db "", $00
msg0c5:
	db "", $00
msg0c6:
	db "", $00
msg0c7:
	db "", $00
msg0c8:
	db "", $00
msg0c9:
	db "", $00
msg0ca:
	db "", $00
msg0cb:
	db "", $00
msg0cc:
	db "", $00
msg0cd:
	db "", $00
msg0ce:
	db "", $00
msg0cf:
	db "", $00
msg0d0:
	db "", $00
msg0d1:
	db "", $00
msg0d2:
	db "", $00
msg0d3:
	db "", $00
msg0d4:
	db "", $00
msg0d5:
	db "", $00
msg0d6:
	db "", $00
msg0d7:
	db "", $00
msg0d8:
	db "", $00
msg0d9:
	db "", $00
msg0da:
	db "", $00
msg0db:
	db "", $00
msg0dc:
	db "", $00
msg0dd:
	db "", $00
msg0de:
	db "", $00
msg0df:
	db "", $00
msg0e0:
	db "", $00
msg0e1:
	db "", $00
msg0e2:
	db "", $00
msg0e3:
	db "", $00
msg0e4:
	db "", $00
msg0e5:
	db "", $00
msg0e6:
	db "", $00
msg0e7:
	db "", $00
msg0e8:
	db "", $00
msg0e9:
	db "", $00
msg0ea:
	db "", $00
msg0eb:
	db "", $00
msg0ec:
	db "", $00
msg0ed:
	db "", $00
msg0ee:
	db "", $00
msg0ef:
	db "", $00
msg0f0:
	db "", $00
msg0f1:
	db "", $00
msg0f2:
	db "", $00
msg0f3:
	db "", $00
msg0f4:
	db "", $00
msg0f5:
	db "", $00
msg0f6:
	db "", $00
msg0f7:
	db "", $00
msg0f8:
	db "", $00
msg0f9:
	db "", $00
msg0fa:
	db "", $00
msg0fb:
	db "", $00
msg0fc:
	db "", $00
msg0fd:
	db "", $00
msg0fe:
	db "", $00
msg0ff:
	db "", $00
