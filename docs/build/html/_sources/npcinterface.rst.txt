NPC Interface
=============

This interface defines common attributes and behvaiors for all npcs

Name 
Mini Game
Happiness
Dialog
Door/Space

Happiness
---------

Hapiness will affect the grey scale of the npc and the surrounding door/space. Happineess will map from 0 - 100 to alpha levels of the full colored sprites and greyscale sprite. The combined alpha between the two types of sprites will add up to a full opaque sprite. 

Door/Space
----------

The door space will have various states that will change depending on the characters happiness. These states will cycle throught these states using happiness threshold levels. 

Dialog
------ 

TBD

Mini Game
---------

Each character will have a mini game associated with it. Mini game implementation will vary but will be interacted with through the mini game interface each will extend from. 