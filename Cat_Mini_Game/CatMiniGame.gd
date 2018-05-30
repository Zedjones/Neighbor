extends "res://MiniGame.gd"
var CatColors = preload("res://GlobalData.gd").CatColor
export (PackedScene) var Cat

var targetColor = CatColors.Orange
var gameOver = false


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


func checkCat(cat):
	print("cat checked: ", cat.color )
	if(targetColor == cat.color):
		#print("found cat!")
		cat.right_cat()
		endGame()
	else:
		#print("keep trying")
		cat.wrong_cat()
	
func setTargetColor(color):
	targetColor = color;
	
func getColor():
	return randi() % 5
	
	# GameManager or Character will call this to talk to mini-game
# @param dialogue_choices - a DialogueChoices enum item 
func set_points(dialogue_choices):
	pass
	
# Whether or not the game is complete 
func is_game_over():
	return false
	
# GameManager will call this to get the outcome from the mini-game
# @return - a GameOutcomes enum item
func get_score():
	return GameOutcomes.BETTER
	
func endGame():
	print("ending game")
	gameOver = true
	$CatSpawnTimer.stop()
	$EndGameTimer.start()
	


func _on_GameTimer_timeout():
	print("Game timed out")
	endGame()


func _on_EndGameTimer_timeout():
	print("return to overworld")

