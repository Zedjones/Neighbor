extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var animation = "Walk Cycle" 
export var MIN_TIME = 4 
export var MAX_TIME = 12
var step

var distanceTimer
var rightSpeed = 0.1
var leftSpeed = -0.1
var currentSpeed = rightSpeed
var motion = Vector2()
var startingXPos

func _ready():
	step = $"../../NPCSprite/Animations".get_animation(animation).length
	startingXPos = $"../../".position.x
	distanceTimer = randi()%51+1

func update(delta):
	UpdateDirectionAndMovement()
	
	if distanceTimer <= 0:
		distanceTimer = randi()%51+1
		currentSpeed = -currentSpeed
	
	motion = $"../../".move_and_slide(motion)

func UpdateDirectionAndMovement():
	if motion.x > 0:
		get_node("../../NPCSprite").set_flip_h(false)
		get_node("../../Idle").set_flip_h(false)
	else:
		get_node("../../NPCSprite").set_flip_h(true)
		get_node("../../Idle").set_flip_h(true)
	distanceTimer -= 1
	
	
	if $"../../".position.x > startingXPos + 20:
		currentSpeed = leftSpeed
	elif $"../../".position.x < startingXPos - 20:
		currentSpeed = rightSpeed
		
	motion.x += currentSpeed

func switched(from_state):
	print("Entering walk")
	$"../../NPCSprite/Animations".queue(animation)
	$"../StateTimer".start_timer(MIN_TIME, MAX_TIME, int(step))