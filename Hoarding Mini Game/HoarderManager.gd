extends "res://MiniGame.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(NodePath) var boxes_path
export(int) var current_items 
var boxes_dict = {}
var current_target
var current_item
const boxes_size = Vector2(3, 2)
var game_over = false

func mod(x, m):
	return (x % m + m) % m

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var boxes = get_node(boxes_path)
	for box in boxes.get_children():
		boxes_dict[box.box_pos] = box
	current_target = boxes_dict[Vector2(0, 0)]
	current_item = $"CurrentItem"

func _process(delta):
	var diff = Vector2(0, 0)
	var new_pos = Vector2(0, 0)
	var curr_pos = current_target.box_pos
	if Input.is_action_just_pressed("ui_right"):
		diff.x += 1
	if Input.is_action_just_pressed("ui_left"):
		diff.x -= 1
	if Input.is_action_just_pressed("ui_down"):
		diff.y += 1
	if Input.is_action_just_pressed("ui_up"):
		diff.y -= 1
	new_pos.x = mod(int(curr_pos.x + diff.x), int(boxes_size.x))
	new_pos.y = mod(int(curr_pos.y + diff.y), int(boxes_size.y))
	if new_pos.x == 1 and new_pos.y == 1:
		if diff.x == -1:
			new_pos.x -= 1
		elif diff.x == 1:
			new_pos.x += 1
		elif diff.y == 1 or diff.y == -1:
			new_pos.y -= 1
	current_target = boxes_dict[new_pos]
	$"Selection".position = current_target.position
	if Input.is_action_just_pressed("ui_select"):
		current_item.start_moving_towards(current_target)
		var scene = load("res://Hoarding Mini Game/Entities/CurrentItem.tscn")
		current_item = scene.instance()
		current_item.sprites_list = NodePath("../Sprites")
		add_child(current_item)
		
func remove_item():
	current_items -= 1
	
func add_item():
	current_items += 1

func _on_GameTimer_timeout():
	game_over = true
	
func set_points(dialogue):
	$HoarderHand.set_points(dialogue)

func is_game_over():
	return game_over
	
func get_score():
	if current_items < 15:
		return GameOutcomes.BETTER
	else:
		return GameOutcomes.WORSE
