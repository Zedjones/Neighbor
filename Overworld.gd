extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_PlayButton_pressed():
	print($Camera2D.position)
	$Tween.interpolate_property($Camera2D, "position", $Camera2D.position, 
		Vector2($Camera2D.position.x, get_viewport().get_size().y/2 + 51), 5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()

