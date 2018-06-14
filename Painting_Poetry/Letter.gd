extends Label

var vertMove = true
var horizMove = true

var vertTime = 0
var horizTime = 0

var randScale

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func spawn_letter(txt):
	text = txt
	
func kill_letter():
	queue_free()