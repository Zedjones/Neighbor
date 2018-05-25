extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(NodePath) var anchors
export(NodePath) var boxes
var items_to_steal = 10
var times_to_steal = []
var anchor_dict = {}
var times_dict = {}
var total_time = 30
var moving = false 
var curr_target

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	var items_to_add = items_to_steal	
	while(items_to_add != 0):
		var random_time = randi() % total_time
		if not times_to_steal.has(random_time):
			times_to_steal.append(random_time)
			items_to_add -= 1
	print(times_to_steal)
	var box_children = get_node(boxes).get_children()
	var anchor_children = get_node(anchors).get_children()
	for ind in range(0, anchor_children.size()):
		anchor_dict[anchor_children[ind]] = box_children[ind]
	for time in times_to_steal:
		var rand_ind = randi() % anchor_children.size()
		times_dict[time] = anchor_children[rand_ind]

func init(items_to_steal, total_time):
	self.items_to_steal = items_to_steal
	self.total_time = total_time

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var time = int($"../GameTimer".time_left)
	print(time)
	if moving:
		print(curr_target)
		moving = false
	elif times_to_steal.has(time):
		var anchor = times_dict[time]
		position = anchor.position
		curr_target = anchor_dict[anchor]
		times_to_steal.remove(time)
		moving = true