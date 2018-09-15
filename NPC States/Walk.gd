extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var animation = "Walk Cycle" 
export var MIN_TIME = 4 
export var MAX_TIME = 12
var curr_direction
var step

func _ready():
	step = $"../../NPCSprite/Animations".get_animation(animation).length

func update(delta):
	if curr_direction != null:
		$"../../".move_and_collide(curr_direction*delta)

func switched(from_state):
	print("Entering walk")
	curr_direction = null
	$"../../NPCSprite/Animations".queue(animation)
	$"../StateTimer".start_timer(MIN_TIME, MAX_TIME, int(step))
	_on_MovementTimer_timeout()

func _on_MovementTimer_timeout():
	randomize()
	var new_timeout = rand_range(1, 5)
	$"../../MovementTimer".wait_time = new_timeout
	var rand_direction = int(rand_range(0, 2))
	match rand_direction:
		0:
			curr_direction = Vector2(-5, 0)
			get_node("../../NPCSprite").set_flip_h(true)
			get_node("../../Idle").set_flip_h(true)
			get_node("../../Walking").set_flip_h(true)
		1:
			curr_direction = Vector2(5, 0)
			get_node("../../NPCSprite").set_flip_h(false)
			get_node("../../Idle").set_flip_h(false)
			get_node("../../Walking").set_flip_h(false)
	$"../../MovementTimer".start()