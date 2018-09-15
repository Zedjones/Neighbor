extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0,-1)
export (float) var happiness = 0
var is_paused

func _ready():
	$"PlayerSprite/AnimationPlayer".play("Idle Animation")

func _process(delta):
	motion.y += 10
	
	if not is_paused:
		if Input.is_action_pressed("ui_right"):
			get_node("PlayerSprite").set_flip_h(false)
			get_node("Idle").set_flip_h(false)
			get_node("Walking").set_flip_h(false)
			if motion.x == 0:
				$"Walking".show()
				$"Idle".hide()
				$"PlayerSprite/AnimationPlayer".play("Walk Cycle")
			motion.x = 100
		elif Input.is_action_pressed("ui_left"):
			get_node("PlayerSprite").set_flip_h(true)
			get_node("Idle").set_flip_h(true)
			get_node("Walking").set_flip_h(true)
			if motion.x == 0:
				$"Walking".show()
				$"Idle".hide()
				$"PlayerSprite/AnimationPlayer".play("Walk Cycle")
			motion.x = -100
		else:
			if motion.x != 0:
				$"Idle".show()
				$"Walking".hide()
				$"PlayerSprite/AnimationPlayer".play("Idle Animation")
			motion.x = 0
		
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = -100
	
		motion = move_and_slide(motion, UP)