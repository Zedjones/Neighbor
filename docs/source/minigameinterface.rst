Mini Game Interface
===================

The mini game interface serves to abstract out a communication interface that the game manager can use to communicate with the characters' mini games. 

This inteface implmenets the following functionality. 

Start Game
~~~~~~~~~~

Function called by the Game Manager to instruct the mini game to begin

Game Ended
~~~~~~~~~~

Signal from the mini game in which the Game Manager will connect to prior to starting the mini game. This signal will be fired from the mini game when the game has ended. 

Score
~~~~~

Score value for the mini game. This value will be set to one of the values defined by GameOutcomes. 
This value is returned to the game manager when the signal is emitted. 

Difficulty
~~~~~~~~~~
Difficulty value passed in to the mini game from the game manager to set the initial difficulty level of the mini game. This value is originally obtained from the dialog system. Difficulty of the mini game is determined in the game manager based on the exit response from the dialog system.