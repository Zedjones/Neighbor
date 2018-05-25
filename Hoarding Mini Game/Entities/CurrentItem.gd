extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum ItemType {TRASH, RECYCLING, ELECTRONICS, PAPER, CLOTHES}
var type = ItemType.TRASH
export(NodePath) var sprites_list
export(int) var SPEED
var target


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	type = ItemType.keys()[randi() % ItemType.size()]
	var new_sprite = get_node(sprites_list).get_sprite(type)
	$"Sprite".region_rect = new_sprite.region_rect
	print(type)
	
func _process(delta):
	if target != null:
		var move_vect = (target.position - position).normalized()
		position += (move_vect * SPEED)

func start_moving_towards(target):
	self.target = target

func _on_CurrentItem_area_entered(body):
	if target == body:
		hide()