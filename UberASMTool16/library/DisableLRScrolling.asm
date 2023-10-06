main: 
STZ $1401 
RTL

;This disables L/R scrolling automatically in all levels.  
;To exempt a level from this, change the code in this file to as follows:
; 
;
;!freeRAM = [insert your FreeRAM address here]
;
;main:
;    LDA !freeRAM : BNE +
;    STZ $1401
;+   RTL 

;Then, when you're inserting UberASMs for individual levels,
;make the following file for the level that you want to enable
;L/R scrolling in:

;!freeRAM = [same FreeRAM address as in the Gamemode file]
;
;init:
;    INC !freeRAM
;    RTL