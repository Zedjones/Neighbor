extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(NodePath) var anchors
var items_to_steal = 10
var times_to_steal = []
var total_time = 30

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

func init(items_to_steal, total_time):
	self.items_to_steal = items_to_steal
	self.total_time = total_time

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
