231	0	This block is designed so that if you upthrow a sprite like a shell or throwblock at two of these blocks together, the sprite won't get caught between the two and lose its angular momentum, falling straight down. Do NOT place this block such that sprites can be thrown at it horizontally, or else they'll simply pass through it.
276	0	Sprites and Mario can fall down through these, but can't go back up
277	0	Sprites and Mario can pass through these when going right, but can't go back left
278	0	Sprites and Mario can pass through these when going left, but can't go back right
286	0	1F0 which disappears after item grabbed - useful for shell levels
289	0	A small door that can be entered by pressing up if Mario is touching it anywhere, as opposed to the vanilla door, which has a much smaller hitbox. Note that in its default state, big Mario can enter this door, too. This can easily be changed, though.
297	0	Kills player, even if you're big Mario or have a powerup
299	0	Kills player in all sitations, even with Yoshi or star power
29a	0	Hurts Mario, but allows sprites to pass. By default, it's set so that a vine will eat through the blocks. You can change this, though.
29b	0	A spike with pixel perfect interaction.
29c	0	A spike with pixel perfect interaction.
29d	0	A spike with pixel perfect interaction.
29e	0	A spike with pixel perfect interaction.
2a0	0	Solid for sprites, but allows Mario to pass
2a1	0	Solid for Mario, but allows sprites to pass. If you don't like the look of the normal yellow sprite-pass block, I've also included a block graphic in the same style as the red light switch, set to act the same as this.
2a2	0	Kills all sprites which interact with blocks - even if you're riding Yoshi, and even if Yoshi has a sprite in his mouth. Note, though, that if you destroy a vanilla spring, it will warp Mario. This is an unavoidable behavior of all sprite killers, though custom sprite 20 is a spring disassembly, and won't be affected by this. I've also included another sprite killer, KillsTheSpritesYouSpecify.asm, where springs are automatically whitelisted.
2a3	0	Sprite only triangle, will bounce kicked sprites if they're going rightward
2a4	0	Triangle that's only solid for sprites, and doesn't require 1EB block underneath
2a9	0	Instant power-down, with no temporary invincibility
2b0	0	A regular on-off block, solid when the switch is on
2b1	0	A regular on-off block, which only becomes solid when the switch is turned off
2b2	0	An on-off death block, solid when the switch is on
2b3	0	An on-off death block, solid when the switch is on
2c0	0	Gives feather power-up with no delay
2c1	0	Bounces a moving throwblock.
2c2	0	Will spawn a throwblock whenever you grab it (as many times as you want). Set to act as 130 by default.
2c4	0	This is like normal water, except it automatically has buoyancy for sprites, without having to enable this in Lunar Magic. Note that some sprites, like the floating spike ball (A4), apparently still require buoyancy to be enabled in Lunar Magic itself.
2d1	0	This is a normal sprite solid block, except it's solid for Mario when he's riding Yoshi.
2d2	0	SingleUseOnoffSwitch.asm
314	0	This stops p-speed if you have it
315	0	When you touch this block, Mario will face right if he had been facing left
316	0	When you touch this block, Mario will face left if he had been facing right
317	0	Disables vertical scrolling.
318	0	Enables vertical scrolling.
319	0	Disables horizontal scrolling.
31a	0	Enables horizontal scrolling.
31b	0	This forces the camera to follow Mario's upward movement when you pass through it, useful for those times that the camera doesn't do so naturally
31c	0	KillStarPower.asm
31d	0	This is just like a normal throwblock, but corrected for spin oscillation for reliable grabbing. That is, if you're spinning in midair and try to grab this, your grabbing hitbox won't oscillate back and forth on either side of Mario. (In this sense, it's similar to the cape-spin fix.)
31e	0	This lets the sprite-only triangle work in layer 2 levels, where it normally doesn't work at all.
31f	0	This lets the sprite-only triangle work in layer 2 levels, where it normally doesn't work at all.
324	0	Sprites in this block will behave like they're in water, moving and falling slowly. Splash GFX disabled by default. Note that some sprites, like the floating spike ball (A4), apparently still require buoyancy to be enabled in Lunar Magic itself.
325	0	Invisible block that, when Mario touches it, resets the on/off state to on if it's currently off, but does nothing if it's already off
326	0	Invisible block that, when Mario touches it, resets the on/off state to off if it's currently on, but does nothing if it's already off
327	0	Instantly teleports the player to the level that you specify in the file.
32b	0	Exits the level without triggering any event.
32c	0	Gives instant p-speed
32d	0	This sprite killer allows you to put specific vanilla and custom sprites on a whitelist, so they won't be killed by it. Note, however, that it currently doesn't kill Yoshi if you go through these blocks while riding him. (The other sprite killer does, though.)
32e	0	A vanilla horizontal exit pipe, except that you can enter it while in midair (you don't need to be standing on anything solid).
331	0	Instantly teleports the player to the level that you specify in the file.
334	0	Kills player, even if you're big Mario or have a powerup
33a	0	Sprites and Mario can pass through these when going right, but can't go back left
33c	0	This block is designed so that if you upthrow a sprite like a shell or throwblock at two of these blocks together, the sprite won't get caught between the two and lose its angular momentum, falling straight down. Do NOT place this block such that sprites can be thrown at it horizontally, or else they'll simply pass through it.
33d	0	This block is designed so that if you upthrow a sprite like a shell or throwblock at two of these blocks together, the sprite won't get caught between the two and lose its angular momentum, falling straight down. Do NOT place this block such that sprites can be thrown at it horizontally, or else they'll simply pass through it.
34b	0	This sprite killer allows you to put specific vanilla and custom sprites on a whitelist, so they won't be killed by it. Note, however, that it currently doesn't kill Yoshi if you go through these blocks while riding him. (The other sprite killer does, though.)
34e	0	This is, in effect, a fixed version of vanilla lava, which doesn't allow Mario to swim in the top of it, and destroys sprites kicked into it with a lava splash (except for podoboos), no matter what part of it they touch.
354	0	Allows for an instant dropoff from a gradual or normal slope, without having to place another tile with a flat top first.
35c	0	A vertical pipe with its own defined level exit, so that multiple pipes leading to different level numbers can be put on the same screen.
35e	0	This is like the normal lava, except Mario can't swim in the top of it, and it automatically has buoyancy for sprites, without having to enable this in Lunar Magic.
37c	0	A horizontal pipe with its own defined level exit, so that multiple pipes leading to different level numbers can be put on the same screen.
3a0	0	An ON/OFF switch that is controlled by Mario's fireball
3a4	0	Hurts or Kill if not holding a sprite
3a5	0	Instantly teleports the player to the level that you specify in the file.
3a6	0	A block that acts like a mid-air suspended Spiny.
3a7	0	A block that acts like a stationary Swooper.
3c1	0	Solid for sprites, but allows Mario to pass
3c2	0	Solid for Mario, but allows sprites to pass. If you don't like the look of the normal yellow sprite-pass block, I've also included a block graphic in the same style as the red light switch, set to act the same as this.
3d0	0	Stun the player when caped
3d2	0	Hurts Mario if he is carrying an item
3d3	0	Hurts Mario if he is carrying an item
3d4	0	Hurts Mario if he is carrying an item
3e2	0	Hurts Mario if he is carrying an item
3e3	0	Hurts Mario if he is carrying an item
3e4	0	Hurts Mario if he is carrying an item
3f0	0	Sets the blue p-switch timer to max, and play the correct sound effect.
3f2	0	Hurts Mario if he is carrying an item
3f3	0	Hurts Mario if he is carrying an item
3f4	0	Hurts Mario if he is carrying an item
400	0	A block that bounces sprites up, but doesn't affect Mario.
401	0	The top of the 1x2 key block.
402	0	The top of the 1x3 key block.
403	0	The left of the 2x1 key block.
404	0	The right of the 2x1 key block.
405	0	This block spawns a throwblock that is automatically carried and destroys itself afterwards.
406	0	This block spawns a key that is automatically carried and destroys itself afterwards.
407	0	This block spawns a spring that is automatically carried and destroys itself afterwards.
408	0	This block spawns a galoomba that is automatically carried and destroys itself afterwards.
409	0	This block spawns a baby yoshi that is automatically carried and destroys itself afterwards.
410	0	A block that bounces you up if you're spinjumping or on Yoshi and does nothing if you are not.
411	0	The bottom of the 1x2 key block.
412	0	The middle of the 1x3 key block.
413	0	The left of the 3x1 key block.
414	0	The middle of the 3x1 key block.
415	0	This block spawns a P-Switch that is automatically carried and destroys itself afterwards.
416	0	This block spawns a shell that is automatically carried and destroys itself afterwards.
417	0	This block spawns a bomb that is automatically carried and destroys itself afterwards.
418	0	This block spawns a beetle that is automatically carried and destroys itself afterwards.
419	0	This block spawns a mechakoopa that is automatically carried and destroys itself afterwards.
41b	0	MuncherHaveToDuckUnder-8PixelsOffGround.asm
422	0	The bottom of the 1x3 key block.
423	0	The right of the 3x1 key block.
424	0	This block boosts the player upwards.
425	0	Right-moving conveyor. Direction controlled by on/off switch.
431	0	A Donut Lift, which will fall shortly after being stepped on.
435	0	Left-moving conveyor. Direction controlled by on/off switch.
441	0	Block that will activate the midway flag without playing a sound.
444	0	Decreases the coin counter unless it's already zero, in which case it substracts an 1-Up.
445	0	CoinIncreaseTime.asm
448	0	Not a real coin, so that it doesn't increment coin count.
570	0	Will increase the A button ammo.
600	0	SSP_Tiles/caps/enterable/default/top_vertical_pipe_cap_L.asm
601	0	SSP_Tiles/caps/enterable/default/top_vertical_pipe_cap_R.asm
602	0	SSP_Tiles/pass_if_in_pipe.asm
603	0	SSP_Tiles/pass_if_in_pipe.asm
604	0	SSP_Tiles/caps/exit_only/top_vertical_pipe_cap_L_exit.asm
605	0	SSP_Tiles/caps/exit_only/top_vertical_pipe_cap_R_exit.asm
606	0	SSP_Tiles/caps/enterable/default/top_vertical_pipe_cap_L.asm
607	0	SSP_Tiles/caps/enterable/default/top_vertical_pipe_cap_R.asm
608	0	SSP_Tiles/pass_if_in_pipe.asm
609	0	SSP_Tiles/pass_if_in_pipe.asm
60a	0	SSP_Tiles/pass_if_in_pipe.asm
60b	0	SSP_Tiles/pass_if_in_pipe.asm
60c	0	SSP_Tiles/caps/enterable/enter_horiz_midair/left_horizontal_pipe_cap_small.asm
60d	0	SSP_Tiles/caps/enterable/enter_horiz_midair/right_horizontal_pipe_cap_small.asm
60e	0	SSP_Tiles/caps/enterable/enter_horiz_midair/left_horizontal_pipe_cap_small.asm
60f	0	SSP_Tiles/caps/enterable/enter_horiz_midair/right_horizontal_pipe_cap_small.asm
610	0	SSP_Tiles/caps/enterable/default/bottom_vertical_pipe_cap_L.asm
611	0	SSP_Tiles/caps/enterable/default/bottom_vertical_pipe_cap_R.asm
612	0	SSP_Tiles/caps/enterable/default/left_horizontal_pipe_cap_B.asm
613	0	SSP_Tiles/caps/enterable/default/right_horizontal_pipe_cap_B.asm
614	0	SSP_Tiles/caps/enterable/default/bottom_vertical_pipe_cap_L.asm
615	0	SSP_Tiles/caps/enterable/default/bottom_vertical_pipe_cap_R.asm
616	0	SSP_Tiles/caps/exit_only/bottom_vertical_pipe_cap_L_exit.asm
617	0	SSP_Tiles/caps/exit_only/bottom_vertical_pipe_cap_R_exit.asm
618	0	SSP_Tiles/caps/exit_only/left_horizontal_pipe_cap_B_exit.asm
619	0	SSP_Tiles/caps/enterable/default/right_horizontal_pipe_cap_B.asm
61a	0	SSP_Tiles/caps/enterable/default/left_horizontal_pipe_cap_B.asm
61b	0	SSP_Tiles/caps/exit_only/right_horizontal_pipe_cap_B_exit.asm
61c	0	SSP_Tiles/pass_if_in_pipe.asm
61d	0	SSP_Tiles/pass_if_in_pipe.asm
61e	0	SSP_Tiles/pass_if_in_pipe.asm
61f	0	SSP_Tiles/pass_if_in_pipe.asm
620	0	SSP_Tiles/caps/enterable/default/top_vertical_pipe_cap_small.asm
621	0	SSP_Tiles/caps/enterable/default/left_horizontal_pipe_cap_small.asm
622	0	SSP_Tiles/caps/enterable/default/right_horizontal_pipe_cap_small.asm
624	0	SSP_Tiles/caps/exit_only/top_vertical_pipe_cap_small_exit.asm
625	0	SSP_Tiles/caps/enterable/default/top_vertical_pipe_cap_small.asm
626	0	SSP_Tiles/caps/exit_only/left_horizontal_pipe_cap_B_exit.asm
627	0	SSP_Tiles/caps/enterable/default/right_horizontal_pipe_cap_small.asm
628	0	SSP_Tiles/pass_if_in_pipe.asm
629	0	SSP_Tiles/pass_if_in_pipe.asm
62a	0	SSP_Tiles/pass_if_in_pipe.asm
62b	0	SSP_Tiles/pass_if_in_pipe.asm
62c	0	SSP_Tiles/caps/enterable/enter_horiz_midair/left_horizontal_pipe_cap_B.asm
62d	0	SSP_Tiles/caps/enterable/enter_horiz_midair/right_horizontal_pipe_cap_B.asm
62e	0	SSP_Tiles/caps/enterable/enter_horiz_midair/left_horizontal_pipe_cap_B.asm
62f	0	SSP_Tiles/caps/enterable/enter_horiz_midair/right_horizontal_pipe_cap_B.asm
630	0	SSP_Tiles/caps/enterable/default/bottom_vertical_pipe_cap_small.asm
634	0	SSP_Tiles/caps/enterable/default/bottom_vertical_pipe_cap_small.asm
635	0	SSP_Tiles/caps/exit_only/bottom_vertical_pipe_cap_small_exit.asm
636	0	SSP_Tiles/caps/enterable/default/left_horizontal_pipe_cap_small.asm
637	0	SSP_Tiles/caps/exit_only/right_horizontal_pipe_cap_B_exit.asm
638	0	SSP_Tiles/turn_up-right.asm
639	0	SSP_Tiles/pass_if_in_pipe.asm
63a	0	SSP_Tiles/pass_if_in_pipe.asm
63b	0	SSP_Tiles/turn_right-down.asm
63c	0	SSP_Tiles/turn_up-right_small.asm
63d	0	SSP_Tiles/turn_right-down_small.asm
63e	0	SSP_Tiles/pass_if_in_pipe.asm
640	0	SSP_Tiles/pass_if_in_pipe.asm
641	0	SSP_Tiles/pass_if_in_pipe.asm
642	0	SSP_Tiles/pass_if_in_pipe.asm
643	0	SSP_Tiles/pass_if_in_pipe.asm
644	0	SSP_Tiles/pass_if_in_pipe.asm
645	0	SSP_Tiles/pass_if_in_pipe.asm
648	0	SSP_Tiles/pass_if_in_pipe.asm
649	0	SSP_Tiles/pass_if_in_pipe.asm
64a	0	SSP_Tiles/pass_if_in_pipe.asm
64b	0	SSP_Tiles/pass_if_in_pipe.asm
64c	0	SSP_Tiles/turn_left-up_small.asm
64d	0	SSP_Tiles/turn_down-left_small.asm
650	0	SSP_Tiles/pass_if_in_pipe.asm
651	0	SSP_Tiles/pass_if_in_pipe.asm
652	0	SSP_Tiles/pass_if_in_pipe.asm
653	0	SSP_Tiles/pass_if_in_pipe.asm
654	0	SSP_Tiles/pass_if_in_pipe.asm
655	0	SSP_Tiles/pass_if_in_pipe.asm
658	0	SSP_Tiles/turn_left-up.asm
659	0	SSP_Tiles/pass_if_in_pipe.asm
65a	0	SSP_Tiles/pass_if_in_pipe.asm
65b	0	SSP_Tiles/turn_down-left.asm
baa	0	A one-use note block
bab	0	A block that bounces sprites and mario! Doesn't bounce mario when OFF.
bac	0	A block that bounces sprites and mario! Doesn't bounce mario when ON.
1003	0	A frozen block that disappears when thawed.
1004	0	A frozen multiple coin block.
1005	0	A frozen block that gives a coin.
1006	0	A frozen note block.
1007	0	A frozen ON-OFF block.
1008	0	For use with the horizontal line-guide with the line at the top (tile 92). Allows line-guided sprites to pass through, but blocks Mario.
1009	0	For use with the horizontal line-guide with the line at the bottom (tile 93). Allows line-guided sprites to pass through, but blocks Mario.
100a	0	A frozen version of tile 3A0.
1013	0	A frozen coin.
1014	0	A frozen version of tile 12F.
1018	0	For use with the horizontal line-guide with the line at the top (tile 92). Allows line-guided sprites to pass through, but blocks Mario.
1019	0	For use with the horizontal line-guide with the line at the bottom (tile 93). Allows line-guided sprites to pass through, but blocks Mario.
1023	0	A frozen version of sprite 3E.
1800	0	A teleport block, that teleports the player to level #$012F when the Cursor sprite clicks over it.
1801	0	A teleport block, that teleports the player to level #$012E when the Cursor sprite clicks over it.
1802	0	A teleport block, that teleports the player to level #$0001 when the Cursor sprite clicks over it.
1803	0	A teleport block, that teleports the player to level #$0002 when the Cursor sprite clicks over it.
1804	0	A teleport block, that teleports the player to level #$0003 when the Cursor sprite clicks over it.
1805	0	A teleport block, that teleports the player to level #$0004 when the Cursor sprite clicks over it.
1806	0	A teleport block, that teleports the player to level #$0005 when the Cursor sprite clicks over it.
1807	0	A teleport block, that teleports the player to level #$0006 when the Cursor sprite clicks over it.
1808	0	A teleport block, that teleports the player to level #$0007 when the Cursor sprite clicks over it.
1809	0	A teleport block, that teleports the player to level #$0008 when the Cursor sprite clicks over it.
180a	0	A teleport block, that teleports the player to level #$0009 when the Cursor sprite clicks over it.
180b	0	A teleport block, that teleports the player to level #$000A when the Cursor sprite clicks over it.
180c	0	A teleport block, that teleports the player to level #$000B when the Cursor sprite clicks over it.
180d	0	A teleport block, that teleports the player to level #$000C when the Cursor sprite clicks over it.
180e	0	A teleport block, that teleports the player to level #$000D when the Cursor sprite clicks over it.
180f	0	A teleport block, that teleports the player to level #$000E when the Cursor sprite clicks over it.
1810	0	A teleport block, that teleports the player to level #$000F when the Cursor sprite clicks over it.
1811	0	A teleport block, that teleports the player to level #$0010 when the Cursor sprite clicks over it.
1812	0	A teleport block, that teleports the player to level #$0011 when the Cursor sprite clicks over it.
1813	0	A teleport block, that teleports the player to level #$0012 when the Cursor sprite clicks over it.
1814	0	A teleport block, that teleports the player to level #$0013 when the Cursor sprite clicks over it.
1815	0	A teleport block, that teleports the player to level #$0014 when the Cursor sprite clicks over it.
1816	0	A teleport block, that teleports the player to level #$0015 when the Cursor sprite clicks over it.
1817	0	A teleport block, that teleports the player to level #$0016 when the Cursor sprite clicks over it.
1818	0	A teleport block, that teleports the player to level #$0017 when the Cursor sprite clicks over it.
1819	0	A teleport block, that teleports the player to level #$0018 when the Cursor sprite clicks over it.
181a	0	A teleport block, that teleports the player to level #$0019 when the Cursor sprite clicks over it.
181b	0	A teleport block, that teleports the player to level #$001A when the Cursor sprite clicks over it.
181c	0	A teleport block, that teleports the player to level #$001B when the Cursor sprite clicks over it.
181d	0	A teleport block, that teleports the player to level #$001C when the Cursor sprite clicks over it.
181e	0	A teleport block, that teleports the player to level #$001D when the Cursor sprite clicks over it.
181f	0	A teleport block, that teleports the player to level #$001E when the Cursor sprite clicks over it.
1820	0	A teleport block, that teleports the player to level #$001F when the Cursor sprite clicks over it.
1821	0	A teleport block, that teleports the player to level #$0020 when the Cursor sprite clicks over it.
1822	0	A teleport block, that teleports the player to level #$0021 when the Cursor sprite clicks over it.
1823	0	A teleport block, that teleports the player to level #$0022 when the Cursor sprite clicks over it.
1824	0	A teleport block, that teleports the player to level #$0023 when the Cursor sprite clicks over it.
1825	0	A teleport block, that teleports the player to level #$0024 when the Cursor sprite clicks over it.
1826	0	A teleport block, that teleports the player to level #$0131 when the Cursor sprite clicks over it.
1827	0	A teleport block, that teleports the player to level #$0101 when the Cursor sprite clicks over it.
1828	0	A teleport block, that teleports the player to level #$0102 when the Cursor sprite clicks over it.
1829	0	A teleport block, that teleports the player to level #$0103 when the Cursor sprite clicks over it.
182a	0	A teleport block, that teleports the player to level #$0104 when the Cursor sprite clicks over it.
182b	0	A teleport block, that teleports the player to level #$0105 when the Cursor sprite clicks over it.
182c	0	A teleport block, that teleports the player to level #$0106 when the Cursor sprite clicks over it.
182d	0	A teleport block, that teleports the player to level #$0107 when the Cursor sprite clicks over it.
182e	0	A teleport block, that teleports the player to level #$0108 when the Cursor sprite clicks over it.
182f	0	A teleport block, that teleports the player to level #$0109 when the Cursor sprite clicks over it.
1830	0	A teleport block, that teleports the player to level #$010A when the Cursor sprite clicks over it.
1831	0	A teleport block, that teleports the player to level #$010B when the Cursor sprite clicks over it.
1832	0	A teleport block, that teleports the player to level #$010C when the Cursor sprite clicks over it.
1833	0	A teleport block, that teleports the player to level #$010D when the Cursor sprite clicks over it.
1834	0	A teleport block, that teleports the player to level #$010E when the Cursor sprite clicks over it.
1835	0	A teleport block, that teleports the player to level #$010F when the Cursor sprite clicks over it.
1836	0	A teleport block, that teleports the player to level #$0110 when the Cursor sprite clicks over it.
1837	0	A teleport block, that teleports the player to level #$0111 when the Cursor sprite clicks over it.
1838	0	A teleport block, that teleports the player to level #$0112 when the Cursor sprite clicks over it.
1839	0	A teleport block, that teleports the player to level #$0113 when the Cursor sprite clicks over it.
183a	0	A teleport block, that teleports the player to level #$0114 when the Cursor sprite clicks over it.
183b	0	A teleport block, that teleports the player to level #$0115 when the Cursor sprite clicks over it.
183c	0	A teleport block, that teleports the player to level #$0116 when the Cursor sprite clicks over it.
183d	0	A teleport block, that teleports the player to level #$0117 when the Cursor sprite clicks over it.
183e	0	A teleport block, that teleports the player to level #$0118 when the Cursor sprite clicks over it.
183f	0	A teleport block, that teleports the player to level #$0119 when the Cursor sprite clicks over it.
1840	0	A teleport block, that teleports the player to level #$012A when the Cursor sprite clicks over it.
1841	0	A teleport block, that teleports the player to level #$012B when the Cursor sprite clicks over it.
1842	0	A teleport block, that teleports the player to level #$012C when the Cursor sprite clicks over it.
1843	0	A teleport block, that teleports the player to level #$012D when the Cursor sprite clicks over it.
1846	0	A teleport block, that teleports the player to level #$0130 when the Cursor sprite clicks over it.
1848	0	A teleport block, that teleports the player to level #$0132 when the Cursor sprite clicks over it.
1849	0	A teleport block, that teleports the player to level #$0133 when the Cursor sprite clicks over it.
184a	0	A teleport block, that teleports the player to level #$0134 when the Cursor sprite clicks over it.
184b	0	A teleport block, that teleports the player to level #$0135 when the Cursor sprite clicks over it.
184c	0	A teleport block, that teleports the player to level #$0136 when the Cursor sprite clicks over it.
184d	0	A teleport block, that teleports the player to level #$0137 when the Cursor sprite clicks over it.
184e	0	A teleport block, that teleports the player to level #$0138 when the Cursor sprite clicks over it.
184f	0	A teleport block, that teleports the player to level #$0139 when the Cursor sprite clicks over it.
1850	0	A teleport block, that teleports the player to level #$013A when the Cursor sprite clicks over it.
1851	0	A teleport block, that teleports the player to level #$013B when the Cursor sprite clicks over it.
1852	0	A teleport block, that teleports the player to level #$013C when the Cursor sprite clicks over it.
1853	0	A teleport block, that teleports the player to level #$013D when the Cursor sprite clicks over it.
1854	0	A teleport block, that teleports the player to level #$013E when the Cursor sprite clicks over it.
1855	0	A teleport block, that teleports the player to level #$013F when the Cursor sprite clicks over it.
1856	0	A teleport block, that teleports the player to level #$0140 when the Cursor sprite clicks over it.
1857	0	A teleport block, that teleports the player to level #$0141 when the Cursor sprite clicks over it.
1858	0	A teleport block, that teleports the player to level #$0142 when the Cursor sprite clicks over it.
1859	0	A teleport block, that teleports the player to level #$0143 when the Cursor sprite clicks over it.
185a	0	A teleport block, that teleports the player to level #$0144 when the Cursor sprite clicks over it.
185b	0	A teleport block, that teleports the player to level #$0145 when the Cursor sprite clicks over it.
185c	0	A teleport block, that teleports the player to level #$0146 when the Cursor sprite clicks over it.
185d	0	A teleport block, that teleports the player to level #$0147 when the Cursor sprite clicks over it.
185e	0	A teleport block, that teleports the player to level #$0148 when the Cursor sprite clicks over it.
185f	0	A teleport block, that teleports the player to level #$0149 when the Cursor sprite clicks over it.
1860	0	A teleport block, that teleports the player to level #$014A when the Cursor sprite clicks over it.
1861	0	A teleport block, that teleports the player to level #$014B when the Cursor sprite clicks over it.
1862	0	A teleport block, that teleports the player to level #$014C when the Cursor sprite clicks over it.
1863	0	A teleport block, that teleports the player to level #$014D when the Cursor sprite clicks over it.
1864	0	A teleport block, that teleports the player to level #$014E when the Cursor sprite clicks over it.
1865	0	A teleport block, that teleports the player to level #$014F when the Cursor sprite clicks over it.
1866	0	A teleport block, that teleports the player to level #$0150 when the Cursor sprite clicks over it.
1867	0	A teleport block, that teleports the player to level #$0151 when the Cursor sprite clicks over it.
1868	0	A teleport block, that teleports the player to level #$0152 when the Cursor sprite clicks over it.
1869	0	A teleport block, that teleports the player to level #$0153 when the Cursor sprite clicks over it.
186a	0	A teleport block, that teleports the player to level #$0154 when the Cursor sprite clicks over it.
186b	0	A teleport block, that teleports the player to level #$0155 when the Cursor sprite clicks over it.
186c	0	A teleport block, that teleports the player to level #$0156 when the Cursor sprite clicks over it.
186d	0	A teleport block, that teleports the player to level #$0157 when the Cursor sprite clicks over it.
186e	0	A teleport block, that teleports the player to level #$0158 when the Cursor sprite clicks over it.
186f	0	A teleport block, that teleports the player to level #$0159 when the Cursor sprite clicks over it.
1870	0	A teleport block, that teleports the player to level #$015A when the Cursor sprite clicks over it.
1871	0	A teleport block, that teleports the player to level #$015B when the Cursor sprite clicks over it.
1872	0	A teleport block, that teleports the player to level #$015C when the Cursor sprite clicks over it.
1873	0	A teleport block, that teleports the player to level #$015D when the Cursor sprite clicks over it.
1874	0	A teleport block, that teleports the player to level #$015E when the Cursor sprite clicks over it.
1875	0	A teleport block, that teleports the player to level #$015F when the Cursor sprite clicks over it.
1876	0	A teleport block, that teleports the player to level #$0160 when the Cursor sprite clicks over it.
1877	0	A teleport block, that teleports the player to level #$0161 when the Cursor sprite clicks over it.
1878	0	A teleport block, that teleports the player to level #$0162 when the Cursor sprite clicks over it.
1879	0	A teleport block, that teleports the player to level #$0163 when the Cursor sprite clicks over it.
187a	0	A teleport block, that teleports the player to level #$0164 when the Cursor sprite clicks over it.
187b	0	A teleport block, that teleports the player to level #$011A when the Cursor sprite clicks over it.
187c	0	A teleport block, that teleports the player to level #$011B when the Cursor sprite clicks over it.
187d	0	A teleport block, that teleports the player to level #$011C when the Cursor sprite clicks over it.
187e	0	A teleport block, that teleports the player to level #$011D when the Cursor sprite clicks over it.
187f	0	A teleport block, that teleports the player to level #$011E when the Cursor sprite clicks over it.
1880	0	A teleport block, that teleports the player to level #$011F when the Cursor sprite clicks over it.
1881	0	A teleport block, that teleports the player to level #$0120 when the Cursor sprite clicks over it.
1882	0	A teleport block, that teleports the player to level #$0121 when the Cursor sprite clicks over it.
1883	0	A teleport block, that teleports the player to level #$0122 when the Cursor sprite clicks over it.
1884	0	A teleport block, that teleports the player to level #$0123 when the Cursor sprite clicks over it.
1885	0	A teleport block, that teleports the player to level #$0124 when the Cursor sprite clicks over it.
1886	0	A teleport block, that teleports the player to level #$0125 when the Cursor sprite clicks over it.
1887	0	A teleport block, that teleports the player to level #$0126 when the Cursor sprite clicks over it.
1888	0	A teleport block, that teleports the player to level #$0127 when the Cursor sprite clicks over it.
1889	0	A teleport block, that teleports the player to level #$0128 when the Cursor sprite clicks over it.
188a	0	A teleport block, that teleports the player to level #$0129 when the Cursor sprite clicks over it.
188f	0	Teleports the player.
131		0		This tile is currently non-funtional, but is reserved for a tile that's to be used when you apply a new slope assist tile fix, to prevent clipping. This patch is included with the optional patches. You can see an example of what it fixes if you find Solid Slope Assist Tile on SMWCentral Patches section.
2A5		0		Simple indicator arrows. See tiles 66 and 67 for pink near-the-end-of-level arrows.