extends KinematicBody2D

# class member variables go here, for example:

var distanceTimer
var rightSpeed = 0.1
var leftSpeed = -0.1
var currentSpeed = rightSpeed
var motion = Vector2()
var startingXPos

func _ready():
	distanceTimer = randi()%51+1
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
	else:
		get_node("NPCSprite").set_flip_h(true)
	distanceTimer -= 1
	
	
	if position.x > startingXPos + 20:
		currentSpeed = leftSpeed
	elif position.x < startingXPos - 20:
		currentSpeed = rightSpeed
		
	motion.x += currentSpeed
	pass