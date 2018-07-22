extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (NodePath) var target_path
var target

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	target = get_node(target_path)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Interactive_Object_activated():
	$"Interactive Object".player.position = target.get_child(0).position
	print("Elevator")