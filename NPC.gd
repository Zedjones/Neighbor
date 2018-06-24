extends KinematicBody2D

# class member variables go here, for example:

var distanceTimer
var rightSpeed = 0.1
var leftSpeed = -0.1
var currentSpeed = rightSpeed
var motion = Vector2()
var startingXPos
onready var game_manager = get_node("/root/GameManager")
export (PackedScene) var mini_game
signal player_entered
signal player_exited
signal player_pressed
export (float) var happiness = 0


func _ready():
	distanceTimer = randi()%51+1
	connect("player_entered", game_manager, "set_curr_character")
	connect("player_exited", game_manager, "set_curr_character")
	connect("player_pressed", game_manager,"start_mini_game")
	startingXPos = position.x
	pass

func _process(delta):
	UpdateDirectionAndMovement()
	
	if distanceTimer <= 0:
		distanceTimer = randi()%51+1
		currentSpeed = -currentSpeed
	
	motion = move_and_slide(motion)
	pass

func UpdateDirectionAndMovement():
	if motion.x > 0:
		get_node("NPCSprite").set_flip_h(false)
		get_node("Idle").set_flip_h(false)
	else:
		get_node("NPCSprite").set_flip_h(true)
		get_node("Idle").set_flip_h(true)
	distanceTimer -= 1
	
	
	if position.x > startingXPos + 20:
		currentSpeed = leftSpeed
	elif position.x < startingXPos - 20:
		currentSpeed = rightSpeed
		
	motion.x += currentSpeed
	pass

# Set GameManager current character to the character and 
# call the dialogue blip if it hasn't already been called
func _on_Interactive_Object_activated():
	print("player_entered")
	emit_signal("player_entered", self)
	
# GameManager will call this to adjust happiness after dialogue
# @param points: a float with the number of points to add
func adjust_happiness(points):
	happiness += points

# Set GameManager current character to null 
func _on_IO_exited():
	print("player_exited")
	emit_signal("player_exited", null)


func _on_IOP_activated():
	print("player_pressed")
	emit_signal("player_pressed")

