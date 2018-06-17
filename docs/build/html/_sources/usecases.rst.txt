Use Cases
==============

Player approaches a neighbor
----------------------------

Interactiable element code will emit a signal that will pass the character information to the game mananger. The game manager will then pass dialog information fron the character to the dialog system so that it may generate a speech bubble over the character. 

Player acknowledges a neighbor
------------------------------

When the player approaches the neighbor and triggers the dialog of the neighbor, the player will have to acknowledge the neighbor to progress with the dialog. This will trigger the interactable elmement, on enter if pressed signal. the signal will be processed by the character to pass its information to the game manager to pass to the dialog system to progress the dialog. 

Player ignores a neighbor
-------------------------

When the neighbor speaks as the player approaches, the player may choose to ignore them. In that case, the dialog prompt will remain until the player exits the neighbors region. This would be an interactive element, on exit signal. The signal will tell the dialog system to close the speech bubble. 

Player enters dialog
--------------------

Player loses movement control. The dialog manager navigates through the dialog. 

Player extis dialog (mini game)
-------------------------------

The game manager recieving the exit dialog signal will take the exit status from the dialog system and start the mini game for the currently engaged character. This will call the mini game interface Start Game, passing in the difficulty settings. 

Player extis dialog ( no mini game)
-----------------------------------

The game manager will return player movement control. 

Player goes to his apartment
----------------------------

when the player enters the apartment and presses the select button, it will trigger the interactable object, on enter, if pressed. The result of the signal is to inform the game manager to end the day. 

Day End
-------

The day ends when the player goes to his apartment and presses select. the day wiil end. Current time of night is subtracted from 11 pm and if the delta is positive, its added to the arrival time of the next day. 

As the day ends, the camera pans up to the sky, the sky changes to day time and the next day starts. 

Day Start
---------

The day starts with the camera facing the sky showing the player's apartment and pans down the entire apartment. When the player leaves for work, time skips to evening, sky tweens to dark and the player arrives later in the day. The time of night is dependant on when the player when to sleep the night before. 