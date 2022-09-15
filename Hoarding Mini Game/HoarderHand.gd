extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(NodePath) var anchors
export(NodePath) var boxes
export(int) var SPEED
var items_to_steal = 10
var times_to_steal = []
var anchor_dict = {}
var times_dict = {}
var total_time = 30
var moving = false
var moving_back = false
var curr_anchor
var curr_target

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	var items_to_add = items_to_steal	
	while(items_to_add != 0):
		var random_time = randi() % total_time
		if not times_to_steal.has(random_time) and not times_to_steal.has(random_time - 1) \
		and not times_to_steal.has(random_time + 1):
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
	if moving and $"HoldTimer".is_stopped():
		#get the center of the target
		if overlaps_area(curr_target.get_child(2)):
			$"..".add_item()
			$"HoldTimer".start()
		else:
			var move_vect = (curr_target.position - position).normalized()
			position += (move_vect * SPEED)
	elif moving_back:
		#print(curr_anchor)
		var distance = curr_anchor.position - position
		if abs(distance.x) < 1 and abs(distance.y) < 1:
			moving_back = false
		var move_vect = distance.normalized()
		position += (move_vect * SPEED)
	elif times_to_steal.has(time):
		curr_anchor = times_dict[time]
		position = curr_anchor.position
		if position.y < 0:
			$"Sprite".flip_v = true
		else:
			$"Sprite".flip_v = false
		curr_target = anchor_dict[curr_anchor]
		times_to_steal.remove(times_to_steal.find(time))
		moving = true

func _on_HoldTimer_timeout():
	moving = false
	moving_back = true
	
func set_points(dialogue):
	if dialogue == $"..".DialogueChoices.WORST:
		items_to_steal = 10
	else:
		items_to_steal = 5
