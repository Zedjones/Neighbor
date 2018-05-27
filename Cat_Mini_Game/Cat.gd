extends Area2D
signal on_cat_hit
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
enum CatSpeed { Slow = 1, Normal = 2, Fast = 3, Max = 5}
var speedMod = CatSpeed.Normal;
var facingRight = false;
export (int) var MAX_SPEED
var vel = 0
var isRunning = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$AnimationPlayer.play("grey_run")
	vel = speedMod * 50
	facingRight = position.x < 0
	pass

func _process(delta):
	if(isRunning):
		if(facingRight):
			position.x += vel * delta
		else:
			position.x -= vel * delta
		
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_OrangeCat_input_event(viewport, event, shape_idx):
     #print("in cat space")
	
     if Input.is_mouse_button_pressed(1):
        print("Clicked")
        emit_signal("on_cat_hit") 
		  
	
func flip():
	$RunSprite.flip_h = !$RunSprite.flip_h


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func run():
	isRunning = true;