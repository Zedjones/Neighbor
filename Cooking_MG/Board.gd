extends Sprite

var moveKnife = true

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if moveKnife:
		$Knife.position.x = ((int($Knife.position.x) + 61) % 120) - 60
