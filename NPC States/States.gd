extends Node

enum states {Idle, Walk, Special}
var curr_state
onready var state_map = \
	{states.Idle: $Idle, states.Walk: $Walk, states.Special: $Special}

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func change_state(new_state):
	var state_node = state_map[new_state]
	state_node.switched(curr_state)
	curr_state = new_state