extends Node

enum states {Idle=0, Walk=1, Special=2}
var curr_state
onready var state_map = \
	{states.Idle: $Idle, states.Walk: $Walk, states.Special: $Special}
	
func _ready():
	randomize()
	var new_state = int(floor(rand_range(0, states.size())))
	while new_state == curr_state:
		new_state = int(floor(rand_range(0, states.size())))
	curr_state = new_state
	change_state(new_state)

func _process(delta):
	state_map[curr_state].update(delta)
	
func handle_anim():
	$"../NPCSprite/Animations".stop(true)
	$"../NPCSprite/Animations".play(state_map[curr_state].animation)

func change_state(new_state):
	if new_state == states.Walk:
		$"../Walking".show()
		$"../Idle".hide()
	else:
		$"../Walking".hide()
		$"../Idle".show()
	var state_node = state_map[new_state]
	state_node.switched(curr_state)
	curr_state = new_state