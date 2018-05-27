extends KinematicBody2D

var motion = Vector2()
export(NodePath) var bottomElevator setget setBottom, getBottom
export(NodePath) var topElevator setget setTop, getTop
const UP = Vector2(0,-1)

func getBottom():
	return bottomElevator
func setBottom(newBottom):
	print("setbottom()")
	bottomElevator = newBottom
	call_deferred("set_my_bottom")
func set_my_bottom():
	print("set_my_bottom()") 

func getTop():
	return topElevator
func setTop(newTop):
	print("setbottom()")
	topElevator = newTop
	call_deferred("set_my_bottom")
func set_my_top():
	print("set_my_top()")

func _ready():
	#get_node(bottomElevator).connect("body_entered", self, "_move_to_top")
	pass

func _process(delta):
	motion.y += 10
	
	checkBottomCollision()
	
	if Input.is_action_pressed("ui_right"):
		get_node("PlayerSprite").set_flip_h(false)
		motion.x = 100
	elif Input.is_action_pressed("ui_left"):
		get_node("PlayerSprite").set_flip_h(true)
		motion.x = -100
	else:
		motion.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -100
	
	motion = move_and_slide(motion, UP)
	
	pass
	
func checkBottomCollision():
	#bottomElevator.get_node
	pass

func _move_to_top():
	print("Moving")
	position.y = get_node(topElevator).position.y
	pass
func _move_to_bottom():
	print("Moving")
	position.y = get_node(bottomElevator).position.y
	pass

func _on_Bottom_body_entered(body):
	print(body.name)
	if body.name == "Player" && Input.action_press("ui_accept"):
		_move_to_top()


func _on_Top_body_entered(body):
	print(body.name)
	if body.name == "Player" && Input.is_action_just_pressed("ui_accept"):
		_move_to_bottom()
