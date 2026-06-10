# Pokémon Yellow Upgrade (Text Engine Branch)

This specific branch is not assigned to anyone yet. 
It will be for upgrading the text engine. Any coder assigned to this repo can work on it, but try to communicate. 

Basic information: 
In Generation 1/2, the games support 1 language. For reasons relating to my (KurusuSilver11) true project, Light Pink, I need the engine upgraded to support at least two; English, and Japanese. 

Here's what I know about the current engine: 
It loads the entire english font into VRAM and takes the one-character tiles to make every word. 
Due to this, it can only fully fit one language. There are blank tiles on the one single image with the entire font, but not enough for the japanese font (that one took more, if not all tiles btw). 
Now, I do have ideas on how to change this.
Engezerstorung on the Pret Server gave me the idea to make it load the character tiles needed for the sentence dynamically, in order to fit any language I want. He said it's done similarly in Zelda oracles of ___. 
I have three base ideas on how that'd work.

1. One big image with both fonts. The game sends individual tiles to VRAM dynamically when needed.
2. Every character is a small one-tile image. Mostly if #1 doesn't work.
3. The english font image and the japanese font image. I don't know why this would be the method needed, but I'm putting it out there.

I do not have any further resource, but here's the disassembly I found for the zelda game. I didn't look at the files, so it may be worthless. 
https://github.com/Stewmath/oracles-disasm
It IS a GBC game, so its code should be somewhat compatible. 
In the Zelda game, the font is one image. I don't know where they keep their text engine.
