extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var animation = "Special Animation" 
export var MIN_TIME = 4 
export var MAX_TIME = 12
var step

func _ready():
	step = $"../../NPCSprite/Animations".get_animation(animation).length

func update(delta):
	$"../../".move_and_slide(Vector2(0, 0))

func switched(from_state):
	print("Entering special")
	if from_state == $"..".states.Walk: 
		$"../../Idle".show()
		$"../../Walking".hide()
	$"../../NPCSprite/Animations".queue(animation)
	$"../StateTimer".start_timer(MIN_TIME, MAX_TIME, int(step))