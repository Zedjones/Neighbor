extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum DialogueChoices {Worst, Okay, Better, Best}
var curr_character

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func set_curr_character(character):
	curr_character = character
	
func launch_minigame(dialogue_choices):
	curr_character.launch_minigame(choice)