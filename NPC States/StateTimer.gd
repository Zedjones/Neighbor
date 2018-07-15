extends Timer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var states = $"..".states

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func start_timer(min_time, max_time, step):
	randomize()
	var new_time = int(rand_range(min_time, max_time))
	while new_time % step != 0:
		new_time = int(rand_range(min_time, max_time))
	wait_time = new_time
	start()

func _on_StateTimer_timeout():
	randomize()
	var new_state = int(rand_range(0, states.size()))
	while new_state == $"..".curr_state:
		new_state = int(rand_range(0, states.size()))
	$"..".change_state(new_state)