extends "res://MiniGame.gd"

var foodItems = []
var foodCount = 2
var curr_ingredient
var chopped_ingredient
var chopped = false
var temp1 = "Background/Board/Ingredients/%s"
var temp2 = "Background/Board/CookPot/%s"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	
	if foodItems.size() > 0:
		temp1 = "Background/Board/Ingredients/%s"
		temp2 = "Background/Board/CookPot/%s"
		curr_ingredient = temp1 % foodItems[0]
		chopped_ingredient = temp2 % foodItems[0]
	if Input.is_key_pressed(KEY_SPACE):
		if $Background/Board/Knife.overlaps_area(get_node(curr_ingredient)) and !chopped:
			chopped = true
			get_node(curr_ingredient).hide()
			get_node(chopped_ingredient).show()
			foodItems.remove(0)
			if foodItems.size() > 0:
				curr_ingredient = temp1 % foodItems[0]
				get_node(curr_ingredient).show()
	if $Background/Board/Knife.position.x < -55:
		chopped = false


func _on_Timer_timeout():
	$Background/FoodSelect/RecipeBook.hide()
	$Background/FoodSelect/AssortedFood.show()

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
		foodItems.append("Tomato")
		$Background/FoodSelect/AssortedFood/Tomato.hide()
		_check_food_count()



func _on_Salmon_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(1):
		foodItems.append("Salmon")
		$Background/FoodSelect/AssortedFood/Salmon.hide()
		_check_food_count()
