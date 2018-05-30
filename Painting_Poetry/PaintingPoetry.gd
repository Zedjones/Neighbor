extends Node

export (PackedScene) var Letter

signal kill

var spacing = 20

var sun = ["the world grew darker", "as the sun dove", "into the ocean"]
var star = ["bursting light", "a star flew", "dissipating into the night"]
var fire = ["wild flames", "birthed by a howling bonfire", "lighting up the woods"]
var candle = ["flickering away", "the candle melted", "leaving a puddle"]

var currentLineNum = 0

var currentLines = {"sun": "", "star": "", "fire": "", "candle": ""}

var currentLetterNum = {"sun": 0, "star": 0, "fire": 0, "candle": 0}

var poemLetterPos = Vector2(525, 250)

func _ready():
	$Paintings/Sun.frame = 0
	$Paintings/Star.frame = 4
	$Paintings/Fire.frame = 8
	$Paintings/Candle.frame = 12
	
	setup(currentLineNum)
	
	pass

func _process(delta):
	
	if Input.is_action_pressed("ui_up"):
		emit_signal("kill")
	
	for key in currentLines:
		write_poem(key)
	
	pass

func current_lines(num):
	currentLines["sun"] = sun[num].to_upper()
	currentLines["star"] = star[num].to_upper()
	currentLines["fire"] = fire[num].to_upper()
	currentLines["candle"] = candle[num].to_upper()

func setup(lineNum):
	
	if currentLineNum > 2:
		currentLineNum = 0
	
	current_lines(currentLineNum)
	currentLineNum += 1
	
	var linePos = Vector2(10, 250)
	
	for key in currentLines:
		spawn_line(currentLines[key], linePos)
		linePos.y += 75

func spawn_line(line, pos):
	
	var currentLetterPos = 0
	
	while currentLetterPos < line.length():
		var letter = Letter.instance()
		add_child(letter)
		letter.spawn_letter(line.substr(currentLetterPos,1))
		connect("kill", letter, "kill_letter")
		#letter.add_color_override("font_color", Color(0,0,0))
		currentLetterPos += 1
		letter.rect_position = pos
		pos = Vector2(pos.x + spacing, pos.y)
		
func write_poem(poem):
	if Input.is_action_pressed(currentLines[poem].substr(currentLetterNum[poem], 1)):
		#connect new signal for game reset not just line reset
		print("MATCH")
		currentLetterNum[poem] += 1
	elif currentLines[poem].substr(currentLetterNum[poem], 1) == " ":
		currentLetterNum[poem] += 1
	
	if currentLetterNum[poem] == currentLines[poem].length():
		print("Spawn")
		currentLetterNum[poem] = 0
		spawn_poem(poem)
		poemLetterPos = Vector2(525, poemLetterPos.y + 75)
		emit_signal("kill")
		setup(currentLineNum)

func spawn_poem(poem):
	var currentLetterPos = 0
	
	while currentLetterPos < currentLines[poem].length():
		var letter = Letter.instance()
		add_child(letter)
		letter.spawn_letter(currentLines[poem].substr(currentLetterPos, 1))
		letter.add_color_override("font_color", Color(0,0,0))
		letter.rect_position = poemLetterPos
		poemLetterPos = Vector2(poemLetterPos.x + spacing, poemLetterPos.y)
		currentLetterPos += 1