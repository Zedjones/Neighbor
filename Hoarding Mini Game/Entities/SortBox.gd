extends Area2D

enum ItemType {TRASH, RECYCLING, ELECTRONICS, PAPER, CLOTHES}

export(ItemType) var type
export(Vector2) var box_pos
var numItems

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	numItems = 0

func add_item():
	numItems += 1

func remove_item():
	numItems -= 1