Interactive Element
===================

This is a behavior abstraction that deines common behavior between entities that are interacted with by the player. 

Interaction events 

On Enter
~~~~~~~~

This is a signal that is emitted when the player enters a defined region around the interactable object. Connected node decides the action to take when signal is emmited. 

On Enter, If Pressed
~~~~~~~~~~~~~~~~~~~~

This is a signal that is emmited while the player is overalapping the interactable object. While within range (after On enter, prior to on exit), if the player presses the select button, the signal will be emmitted. Connected node decides the action to take when the signal is emmitted. 

On Exit
~~~~~~~

This is a signal that is emmitted when the player exits the detection region for the interactable object. 

This signal is anticipated to be used with respect to unsolicited dialog from the npcs. When the player enters the range of an npc, ambiguous dialog may come from the npc. If left unacknowledged, the dialog is anticipated to be cleared on exit of npc range. s
