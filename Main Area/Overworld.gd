extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (Color) var dayTime
export (Color) var nightTime

var tweenDuration = 3

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	SceneManager.player = get_node("Player")

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass


func _on_PlayButton_pressed():
	print($Camera2D.position)
	$Tween.interpolate_property($Camera2D, "position", $Camera2D.position, Vector2($Camera2D.position.x, 300 + 51), tweenDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property($Sky, "modulate", dayTime, nightTime, tweenDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()

