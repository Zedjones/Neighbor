extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum ItemType {TRASH, RECYCLING, ELECTRONICS, PAPER, CLOTHES}
var type = ItemType.TRASH
export(NodePath) var sprites_list


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
