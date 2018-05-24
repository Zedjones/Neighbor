extends Node

enum ItemType {TRASH, RECYCLING, ELECTRONICS, PAPER, CLOTHES}

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func get_sprite(type):
	var children = get_children()
	if type == ItemType.RECYCLING:
		var clothes_children = children[0].get_children()
		return clothes_children[randi() % clothes_children.size()]
	elif type == ItemType.TRASH:
		var trash_children = children[1].get_children()
		return trash_children[randi() % trash_children.size()]
	elif type == ItemType.PAPER:
		var paper_children = children[2].get_children()
		return paper_children[randi() % paper_children.size()]
	elif type == ItemType.ELECTRONICS:
		var electronics_children = children[3].get_children()
		return electronics_children[randi() % electronics_children.size()]
	elif type == ItemType.CLOTHES:
		var clothes_children = children[3].get_children()
		return clothes_children[randi() % clothes_children.size()]
	else:
		return "Error"