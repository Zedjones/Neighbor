extends Node
var CatColors = preload("res://GlobalData.gd").CatColor
export (PackedScene) var Cat

var targetColor = CatColors.Orange

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_CatSpawnTimer_timeout():
	
	var cat = Cat.instance()
	
	var position
	var vel = Vector2(0, 0)
	
	cat.color = getColor()
	randomize()
	if(randf() > 0.5):
		$LeftSide/LeftPathFollow.set_offset(randi())
		position = $LeftSide/LeftPathFollow.position
		#cat.set_linear_velocity(Vector2(cat.MAX_SPEED * cat.speedMod, 0))
		cat.flip()
		
	else:
		$RightSide/RightPathFollow.set_offset(randi())
		position = $RightSide/RightPathFollow.position
		#cat.set_linear_velocity(Vector2(-1 * cat.MAX_SPEED * cat.speedMod, 0))
		
	cat.run()
	cat.connect("on_cat_hit", self, "checkCat")
	cat.position = position
	
	add_child(cat)
		
	pass # replace with function body

func checkCat(color):
	print("cat checked: " )
	if(targetColor == color):
		print("found cat!")
	else:
		print("keep trying")
	
func setTargetColor(color):
	targetColor = color;
	
func getColor():
	return randi() % 5
