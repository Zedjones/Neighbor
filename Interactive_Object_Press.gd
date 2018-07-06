extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (NodePath) var player_path
var player
signal activated
signal exited

func _enter_tree():
	# Called every time the node is added to the scene.
	# Initialization here
	player = get_node(player_path)
	print(player_path)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if(player != null):
		if overlaps_body(player):
			if Input.is_action_just_pressed("ui_select") and not player.is_paused:
				#print("player_pressed")
				emit_signal("activated")
			
func _on_Interactive_Object_body_exited(body):
	if body == player:
		#print("player_exited")
		emit_signal("exited")