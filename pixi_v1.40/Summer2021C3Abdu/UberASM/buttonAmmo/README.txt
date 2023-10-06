Q: "How do I insert this ASM?"

A: First lets start with the blocks.
 1.) To begin copy all of the files inside of the "Blocks" folder and put them inside the GPS's "blocks" folder.
 2.) Open GPS's list.txt file and copy the following entries:
	210:25 aButtonAmmo.asm
	211:25 bButtonAmmo.asm
	212:25 xyButtonAmmo.asm
	213:25 xyButtonAmmo.asm
	^^^
	||| 
	Map16 value
     Make sure to change the Map16 values if you have any conflicts.
  3.) After following steps 1 and 2 apply GPS to your to your ROM.

   Applying the UberASM:
  1.) Copy the files in the UberASM folder and insert them in the UberASM's "level" that is if you would like the ASM to run for a specific.
      If you would like this UberASM to apply for all levels copy these files into UberASM's "gamemode" folder.
      *Make sure buttonAmmo.asm and ascii-28.txt are in the same folder together.
  2a.) To insert this ASM for a single level copy the following under the "level:":
	105 buttonAmmo.asm
	^^^
	|||
	Level Number you would like the asm to apply to
  2b.) To insert this ASM for all levels copy the following under the "gamemode:":
	14 buttonAmmo.asm
  3.) Apply UberASM.

Refer to this if you are trying to make multiple UberASM codes run at the same time:
https://www.smwcentral.net/?p=faq&page=1515827-uberasm
Aaaand you are done now you have successfully inserted the ASM to your ROM.

I have provided the graphics file in ExGFXE6 (BG2).bin, and the Map 16 in Map16.map16

NOTE:
The UberASM resets the layer 3 position to 0 in the init be aware if you are using anything involving layer 3.
Make sure you open up and read the options in the ASM file to make any changes you would like.
Make sure the freeram you use is 6 bytes, the current one has 8 bytes but only the first 6 are used.
If you change the freeram in the UberASM file make sure to change the freeram in aButtonAmmo.asm, bButtonAmmo.asm and xyButtonAmmo.asm.

