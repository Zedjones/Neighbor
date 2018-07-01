extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var followPlayer = false
var targetZoom
var tweenDuration = 3
var tween

func _ready():
	tween = get_node("../Tween")


func _process(delta):
	#if(followPlayer):
#		tween.follow_property(self, "zoom", zoom, targetZoom, tweenDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
		#$Tween.interpolate_property($Sky, "modulate", dayTime, nightTime, tweenDuration, Tween.TRANS_QUAD, Tween.EASE_OUT)
		#$Tween.start()
		pass

	
func _input(event):
	var drag = false
	var initPosCam = false
	var initPosMouse = false
	var initPosNode = false
	
	var zoom = get_zoom()
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		if(event.button_index == BUTTON_WHEEL_UP):
			print("Button_Wheel_Up: ", event.position)
			zoom[0] = zoom[0] + 0.25
			zoom[1] = zoom[1] + 0.25
		if(event.button_index == BUTTON_WHEEL_DOWN):
			print("Button_Wheel_Down: ", event.position)
			if(zoom[0] - 0.25 > 0 && zoom[1] - 0.25 > 0):
	            zoom[0] = zoom[0] - 0.25
	            zoom[1] = zoom[1] - 0.25
	
		targetZoom = zoom
			
	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)

#	set_zoom(zoom)
	

	if(drag == true):
	
	    var mouse_pos = get_global_mouse_pos()
	
	    var dist_x = initPosMouse.x - mouse_pos.x
	    var dist_y = initPosMouse.y - mouse_pos.y
	
	    var nx = initPosNode.x - (0 + dist_x)
	    var ny = initPosNode.y - (0 + dist_y)
	
	    get_node("main").set_pos(Vector2(nx,ny))
	
	elif(drag == false):
	    # print("undrag")
	    pass
	
#	if (event.type == InputEvent.MOUSE_BUTTON):
#	    if (event.button_index == BUTTON_WHEEL_UP):
#	        # print("wheel up (event)")
#	        zoom[0] = zoom[0] + 0.25
#	        zoom[1] = zoom[1] + 0.25
#	    if (event.button_index == BUTTON_WHEEL_DOWN):
#	        # print("wheel down (event)")
#	        if(zoom[0] - 0.25 > 0 && zoom[1] - 0.25 > 0):
#	            zoom[0] = zoom[0] - 0.25
#	            zoom[1] = zoom[1] - 0.25
#	    if (event.button_index == BUTTON_MIDDLE):
#	        if(Input.is_mouse_button_pressed(3)):
#	            print("button middle")
#	            initPosMouse = get_global_mouse_pos()
#	            initPosNode = get_node("main").get_pos()
#	            drag = true
#	        else:
#	            print("button middle release")
#	            drag = false

func reset_tween():
	var pos = tween.tell()
	tween.reset_all()
	tween.remove_all()
	
	tween.interpolate_property(self, "zoom", zoom, targetZoom, 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	
	tween.start()
	tween.seek(pos)
	