extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (NodePath) var player_path

func _enter_tree():
	# Called every time the node is added to the scene.
	# Initialization here
	for stairs in get_children():
		stairs.get_child(0).player_path = "../../" + player_path

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass