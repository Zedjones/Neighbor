extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (PackedScene) var mini_game
signal player_entered
export (float) var happiness

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Interactive_Object_activated():
	emit_signal(player_entered)
	
# GameManager will call this to adjust happiness after dialogue
func adjust_happiness(points):
