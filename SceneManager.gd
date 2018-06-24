extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var currentScene

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func load_scene(scene):	
	var instance = scene.instance()
	var world = get_node("/root/World")
	#world.get_tree().paused = true
	world.add_child(instance)
	currentScene = instance
	return instance
	
func unload_scene():
	var world = get_node("/root/World")
	world.remove_child(currentScene)

	

	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
