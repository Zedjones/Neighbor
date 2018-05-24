extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum ItemType {TRASH, RECYCLING, ELECTRONICS, PAPER, CLOTHES}
var type = ItemType.TRASH
export(NodePath) var sprites_list


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	randomize()
	type = ItemType.keys()[randi() % ItemType.size()]
	var new_sprite = get_node(sprites_list).get_sprite(type)
	$"Sprite".region_rect = new_sprite.region_rect
	print(type)
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
