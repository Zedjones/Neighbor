extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (NodePath) var player_path
var player
signal activated

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	player = get_node(player_path)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if overlaps_body(player):
		emit_signal("activated")