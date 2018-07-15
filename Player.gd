extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
var is_paused

func _ready():
	pass

func _process(delta):
	motion.y += 10
	
	if not is_paused:
		if Input.is_action_pressed("ui_right"):
			get_node("PlayerSprite").set_flip_h(false)
			motion.x = 100
		elif Input.is_action_pressed("ui_left"):
			get_node("PlayerSprite").set_flip_h(true)
			motion.x = -100
		else:
			motion.x = 0
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -100
	
		motion = move_and_slide(motion, UP)