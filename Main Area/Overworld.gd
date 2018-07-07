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
	$Tween.connect("tween_completed", self, "follow_player")
	$Camera2D.scroll_to_apartment()
	day_to_night()
	$Tween.start()

func follow_player(object, key):
	print("follow_player")
	$Camera2D.follow_player(true)
#	$Camera2D.scroll_to_min()
	$Tween.disconnect("tween_completed", self, "follow_player")

func night_to_day():
	print("night_to_day")
	$Tween.interpolate_property($Sky, "modulate", nightTime, dayTime, tweenDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
#	$Tween.start()
	
func day_to_night():
	print("day_to_night")
	$Tween.interpolate_property($Sky, "modulate", dayTime, nightTime, tweenDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
#	$Tween.start()

func _on_Bedroom_Object_activated():
	print("player in bedroom")
	$Player.is_paused = true; 
	$"Camera2D/Tween".connect("tween_completed", self, "day_ended")
	
	$Camera2D.scroll_to_max()
	$Camera2D.scroll_to_sky()
	night_to_day()
	

func day_ended():
	print("day ended")	
