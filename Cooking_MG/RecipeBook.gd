extends Sprite

var correct_recipe = true

func _ready():
	if correct_recipe:
		$WrongFood1.hide()
		$WrongFood2.hide()
		$Food3.show()
		$Food4.show()
	else:
		$WrongFood1.show()
		$WrongFood2.show()
		$Food3.hide()
		$Food4.hide()
	
	$Timer.start()

func _process(delta):
	$CountDown.text = str(int($Timer.time_left))
