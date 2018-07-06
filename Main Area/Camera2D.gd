extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export (float) var targetZoomStep = 0.25
var followPlayer = false
var targetZoom
var tweenDuration = 3
var tween
var maxZoom
var minZoom = Vector2(.12, .12)

func _ready():
	#tween = get_node("../Tween")
	maxZoom = get_zoom()
	pass


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
	var zoomStep = targetZoomStep
	var zoomDelta = get_zoom()
	
	print(minZoom)
	
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		if(event.button_index == BUTTON_WHEEL_UP):
#			print("Button_Wheel_Up: ", event.position)
			
			if(zoomDelta[0] + zoomStep > maxZoom[0]):
				zoomStep = clamp(zoomStep, 0, maxZoom[0] - zoomDelta[0])
			if(zoomDelta[1] + zoomStep > maxZoom[1]):
				zoomStep = clamp(zoomStep, 0, maxZoom[1] - zoomDelta[1])
			print(zoomStep)
				
			zoomDelta[0] = zoomDelta[0] + zoomStep
			zoomDelta[1] = zoomDelta[1] + zoomStep
			
		if(event.button_index == BUTTON_WHEEL_DOWN):
			print("Button_Wheel_Down: ", event.position)
#			if(zoomDelta[0] - zoomStep > 0 && zoomDelta[1] - zoomStep > 0):

			if(zoomDelta[0] - zoomStep < minZoom[0]):
				zoomStep = clamp(zoomStep, 0, zoomDelta[0] - minZoom[0])
			if(zoomDelta[1] - zoomStep < minZoom[1]):
				zoomStep = clamp(zoomStep, 0, zoomDelta[1] - minZoom[1] )
			print(zoomStep)
            
			zoomDelta[0] = zoomDelta[0] - zoomStep
			zoomDelta[1] = zoomDelta[1] - zoomStep
			
	
		targetZoom = zoomDelta
		reset_tween()
			
#	elif event is InputEventMouseMotion:
#		print("Mouse Motion at: ", event.position)

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

	$Tween.stop(self, "zoom")

	$Tween.remove_all()
	var currentZoom = get_zoom()
	$Tween.interpolate_property(self, "zoom", currentZoom, targetZoom, 1, Tween.TRANS_QUAD, Tween.EASE_OUT)
	
	$Tween.start()

	