extends Area2D
signal on_cat_hit
var CatColors = preload("res://GlobalData.gd").CatColor

var facingRight = false;
var vel = 0
var isRunning = false
var color = CatColors.Orange
var anim_name
var speed = 30

func _ready():
	randomize()
	vel = (randi() % 4 +1) * speed
	facingRight = position.x < 0

	match color:
		CatColors.Grey:
			anim_name = "grey_run"
		CatColors.Orange:
			anim_name = "orange_run"
		CatColors.Black:
			anim_name = "black_run"
		CatColors.Brown:
			anim_name = "spotted_run"
		CatColors.White:
			anim_name = "white_run"
			
	$AnimationPlayer.play(anim_name)

func _process(delta):
	if(isRunning):
		if(facingRight):
			position.x += vel * delta
		else:
			position.x -= vel * delta


func _on_OrangeCat_input_event(viewport, event, shape_idx):
     if Input.is_mouse_button_pressed(1):
        #print("Clicked")
        emit_signal("on_cat_hit", self) 

func flip():
	$RunSprite.flip_h = !$RunSprite.flip_h

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func run():
	isRunning = true;

func right_cat():
	vel = 0
	match color:
		CatColors.Grey:
			anim_name = "grey_sit"
		CatColors.Orange:
			anim_name = "orange_sit"
		CatColors.Black:
			anim_name = "black_sit"
		CatColors.Brown:
			anim_name = "spotted_sit"
		CatColors.White:
			anim_name = "white_sit"

	$AnimationPlayer.play(anim_name)

func wrong_cat():
	vel = 5 * speed