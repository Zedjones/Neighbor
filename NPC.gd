extends KinematicBody2D

# class member variables go here, for example:

export (PackedScene) var mini_game
signal player_entered
signal player_exited
signal player_pressed
export (float) var happiness = 0


func _ready():
	connect("player_entered", GameManager, "set_curr_character")
	connect("player_exited", GameManager, "set_curr_character")
	#connect("player_pressed", GameManager,"start_mini_game")

# Set GameManager current character to the character and 
# call the dialogue blip if it hasn't already been called
func _on_Interactive_Object_activated():
	print("player_entered")
	emit_signal("player_entered", self)
	
# GameManager will call this to adjust happiness after dialogue
# @param points: a float with the number of points to add
func adjust_happiness(points):
	happiness += points

# Set GameManager current character to null 
func _on_IO_exited():
	print("player_exited")
	emit_signal("player_exited", null)

func _on_IOP_activated():
	print("player_pressed")
	emit_signal("player_pressed")