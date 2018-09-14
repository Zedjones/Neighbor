extends "res://MiniGame.gd"

var foodItems = []
var foodCount = 4
var score = 0
var curr_ingredient
var chopped_ingredient
var chopped = false
var gameTimerRunning = false
var temp1 = "Background/Board/Ingredients/%s"
var temp2 = "Background/Board/CookPot/%s"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	
	if gameTimerRunning:
		if (int($Background/GameTimer.time_left) == 0):
			$Background/TimerCount.text = str(stepify($Background/GameTimer.time_left,0.1))
		else:
			$Background/TimerCount.text = str(int($Background/GameTimer.time_left))
	
	if foodItems.size() > 0:
		temp1 = "Background/Board/Ingredients/%s"
		temp2 = "Background/Board/CookPot/%s"
		curr_ingredient = temp1 % foodItems[0]
		chopped_ingredient = temp2 % foodItems[0]
	
	if Input.is_key_pressed(KEY_SPACE) && gameTimerRunning:
		if $Background/Board/Knife.overlaps_area(get_node(curr_ingredient)) and !chopped:
			chopped = true
			get_node(curr_ingredient).hide()
			get_node(chopped_ingredient).show()
			foodItems.remove(0)
			if foodItems.size() > 0:
				curr_ingredient = temp1 % foodItems[0]
				get_node(curr_ingredient).show()
			else:
				score *= int($Background/GameTimer.time_left)
				$Background/GameTimer.stop()
				_game_over()
	
	if $Background/Board/Knife.position.x < -55:
		chopped = false


func _on_Timer_timeout():
	$Background/FoodSelect/RecipeBook.hide()
	$Background/FoodSelect/AssortedFood.show()
	$Background/GameTimer.start()
	$Background/TimerCount.show()
	gameTimerRunning = true


func _on_GameTimer_timeout():
	if gameTimerRunning:
		_game_over()

func _game_over():
	$Background/Board.moveKnife = false
	gameTimerRunning = false
	score *= 100/(4 * (int($Background/GameTimer.wait_time) - 10))
	print(score)

func _check_food_count():
	foodCount -= 1
	if foodCount == 0:
		$Background/FoodSelect/AssortedFood.hide()
		$Background/Board.show()
		var temp1 = "Background/Board/Ingredients/%s"
		curr_ingredient = temp1 % foodItems[0]
		get_node(curr_ingredient).show()

func _on_Tomato_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(1):
		score += 1
		foodItems.append("Tomato")
		$Background/FoodSelect/AssortedFood/Tomato.hide()
		_check_food_count()



func _on_Salmon_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(1):
		score += 1
		foodItems.append("Salmon")
		$Background/FoodSelect/AssortedFood/Salmon.hide()
		_check_food_count()


func _on_Broccoli_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(1):
		#score -= 1
		foodItems.append("Broccoli")
		$Background/FoodSelect/AssortedFood/Broccoli.hide()
		_check_food_count()


func _on_Garlic_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(1):
		score += 1
		foodItems.append("Garlic")
		$Background/FoodSelect/AssortedFood/Garlic.hide()
		_check_food_count()


func _on_Potato_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(1):
		#score -= 1
		foodItems.append("Potato")
		$Background/FoodSelect/AssortedFood/Potato.hide()
		_check_food_count()


func _on_Chili_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(1):
		score += 1
		foodItems.append("Chili")
		$Background/FoodSelect/AssortedFood/Chili.hide()
		_check_food_count()
