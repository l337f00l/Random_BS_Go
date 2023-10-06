---------------------------------------------
|MARIO + ANIMATED TILES EXGFX PATCH
|BY ROY
---------------------------------------------

(Not inserted by default. Seems to play nicely with Mario DMA, etc.)


This patch enables you to use different ExGFX files for Mario's tiles and the other animated tiles (in place of GFX32 and GFX33) on a per-level basis, or in the title screen. Also inlcudes Podoboo and Yoshi stuff.

You will have to insert the ExGFX through Lunar Magic - the ExGFX files are quite a bit different though. They're 36 kb each. The reason is that the GFX32 and GFX33 are merged into a single file, though each tile in GFX33 is shifted. Use the FluxDefault.bin included as a reference.

After you insert the GFX file(s) through LM, you need to go inside the patch. Then, go down the large table with all the $0032s.
Here you can set the number for your own ExGFX file that you want to use in place of GFX32 and GFX33 in the corresponding levels. (Default ExGFX file should probably be 89.)

If you input:

$0080-$00FF : ExGFX are loaded from ExGFX files 80-FF.
$0100-$0FFF : ExGFX are loaded from ExGFX files 100-FFF, this is a slightly different routine.

You could spot this:

dw $0032,$0032,$0089,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032,$0032 ; Levels 0-F

The leftmost value is for level 0, then level 1, level 2, level 3, etc. Simple, no?


Q: The patch breaks on SA-1!
A: Well, in that case, sorry but there is no other way to fix it. I wrote a wall of text in the ASM which
explains the difficulty of a SA-1 implementation.

Q: I found a bug...
A: Please report them to the patch's comment section!

Q: Credit needed?
A: No.