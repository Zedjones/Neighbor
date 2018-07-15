extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (Color) var dayTime
export (Color) var nightTime

var tweenDuration = 3
enum SkyState { Night, Day }
var currentSkyState; 
var playerStartingPosition

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	SceneManager.player = get_node("Player")
	playerStartingPosition = SceneManager.player.position

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass


func _on_PlayButton_pressed():
	print($Camera2D.position)
	$Tween.connect("tween_completed", self, "on_tween_completed")
	$Camera2D.scroll_to_apartment()
	day_to_night()
	$Tween.start()

func night_to_day():
	print("night_to_day")
	$Tween.interpolate_property($Sky, "modulate", nightTime, dayTime, tweenDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	currentSkyState = SkyState.Day
	$Tween.start()
	
func day_to_night():
	print("day_to_night")
	$Tween.interpolate_property($Sky, "modulate", dayTime, nightTime, tweenDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	currentSkyState = SkyState.Night
	$Tween.start()

func _on_Bedroom_Object_activated():
	print("player in bedroom")
	$Player.is_paused = true; 
	$"Camera2D/Tween".connect("tween_completed", self, "camera_tween_ended")
	
	# zoom out to max
	# scroll to sky
	# night to day
	# scroll to apartment
	# move player
	# follow player
	# give player control
	
#	$Camera2D.follow_player(false)
	$Camera2D.scroll_to_max()
	$Camera2D.scroll_to_sky()
#	night_to_day()

# tween for the sky
func on_tween_completed(object, key):
	print("sky tween ended:", key)
	$Tween.disconnect("tween_completed", self, "on_tween_completed")
	$Tween.stop_all()
	if(key == ":modulate"):
		if($Camera2D.currentPositionState == $Camera2D.PositionState.Apartment):
			$Camera2D.follow_player(true)
	#	 	$Camera2D.scroll_to_min()
		elif(currentSkyState == SkyState.Day && $Camera2D.currentPositionState == $Camera2D.PositionState.Sky):
			$"Camera2D/Tween".connect("tween_completed", self, "camera_tween_ended")	
			TimeManager.next_day()			
			$Camera2D.scroll_to_apartment()

# tween for the camera
func camera_tween_ended(object, key):
	print("camera tween ended: ", key)
	$"Camera2D/Tween".disconnect("tween_completed", self, "camera_tween_ended")
	print ("position: ", $Camera2D.currentPositionState, " scroll: ",  $Camera2D.currentScrollState, " sky: ", currentSkyState)

	
	if(key == ":position"):
		print("position ended")	
		if(currentSkyState == SkyState.Night && $Camera2D.currentPositionState == $Camera2D.PositionState.Sky):
			print("changing to day")
			$Tween.connect("tween_completed", self, "on_tween_completed")
			night_to_day()
			
		elif(currentSkyState == SkyState.Day && $Camera2D.currentPositionState == $Camera2D.PositionState.Apartment):
			#move player
			SceneManager.player.position = playerStartingPosition
			$Camera2D.follow_player(true)			
			$Player.is_paused = false; 
			day_to_night()
	elif(key == ":zoom"):
		print("scroll ended")	
		if($Camera2D.currentScrollState == $Camera2D.ScrollState.Max):
			print("scrolling to sky")	
			$"Camera2D/Tween".connect("tween_completed", self, "camera_tween_ended")
			
#			$Camera2D.scroll_to_sky()
#			pass
		elif($Camera2D.currentScrollState == $Camera2D.ScrollState.Min):
			pass
		if($Camera2D.currentScrollState == $Camera2D.ScrollState.Custom):
			pass
		
		
		
