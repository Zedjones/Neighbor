Time Manager
============

The Time Manager will be the interface for keeping track of the time of day, and day of the week. 

Player comes home at 6 pm 
Player should go to bed by 11 pm
Player goes to work at 9 am
Player passes out at 2 am 

Any time after 11 pm is a tracked offset that is applied to the players arrival time the next night. 

Time passage is entirely action based. The time in the evenings will only pass as the player interacts with the neighbors.

Interation Time Cost
--------------------

=============  ============================  =========
DialogChoices   interaction					 time cost
=============  ============================  =========
1              player ignores after talking  5 min
2              player just plays mini game 	 60 min
3              player gives advice    		 20
4              advice and plays mini game    120 min
=============  ============================  =========

Player goes to sleep
Player home from work
Player interacts


Time
====
class or struct to hold time data

- Add time
- hour 12/24?
- minutes 0-59
- Day (sun, sat)
