extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
enum CatSpeed { Slow = 1, Normal = 2, Fast = 3, Max = 5}
var speedMod = CatSpeed.Normal;
var facingRight = false;
export (int) var MAX_SPEED

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$AnimationPlayer.play("run")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_OrangeCat_input_event(viewport, event, shape_idx):
 #   if event.type == InputEvent.MOUSE_BUTTON \
  #  and event.button_index == BUTTON_LEFT \
   # and event.is_pressed():
     print("Clicked")
