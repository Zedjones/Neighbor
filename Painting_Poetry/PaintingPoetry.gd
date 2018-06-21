extends Node

export (PackedScene) var Letter

signal kill

var spacing = 10

#The Poems
var sun = ["the world grew darker", "as the sun dove", "into the ocean"]
var star = ["bursting light", "a star flew", "dissipating into the night"]
var fire = ["wild flames", "birthed by a howling bonfire", "lighting up the woods"]
var candle = ["flickering away", "the candle melted", "leaving a puddle"]
#The line of whch the poems are on
var currentLineNum = 0
#Sets the string key equal to the current poem line
var currentLines = {"sun": "", "star": "", "fire": "", "candle": ""}
#Which letter of the poem line it is on
var currentLetterNum = {"sun": 0, "star": 0, "fire": 0, "candle": 0}
#Animates the sprites at the end of the game
var paintCount = {"sun": 0, "star": 4, "fire": 8, "candle": 12}
#Where the first line of the poem being written spawns
var poemLetterPos = Vector2(620, 275)

#Figuring out randomization of lines
var linePositions = {"sun": Vector2(10, 250), "star": Vector2(10, 325), "fire": Vector2(10, 400), "candle": Vector2(10, 475)}

func _ready():
	$Paintings/Sun.frame = 0
	$Paintings/Star.frame = 4
	$Paintings/Fire.frame = 8
	$Paintings/Candle.frame = 12
	
	randomize()
	
	setup(currentLineNum)
	
	pass

func _process(delta):
	
#	if Input.is_action_pressed("ui_up"):
#		emit_signal("kill")
	#Checks keyboard presses against the current letter of each potential line
	for key in currentLines:
		write_poem(key)
	
	#Ends, updating the paintings
	if currentLineNum == 3:
		$Paintings/Sun.frame = paintCount["sun"]
		$Paintings/Star.frame = paintCount["star"]
		$Paintings/Fire.frame = paintCount["fire"]
		$Paintings/Candle.frame = paintCount["candle"]
	
	pass
#Sets the current set of lines from each poem, keeping everything uppercase was easier and spacing looks better
func current_lines(num):
	currentLines["sun"] = sun[num].to_upper()
	currentLines["star"] = star[num].to_upper()
	currentLines["fire"] = fire[num].to_upper()
	currentLines["candle"] = candle[num].to_upper()

#Randomizes the vecs in linePositions
func randomize_line_positions():
	var firstPos = randi() % 4
	var secondPos = randi() % 4
	var thirdPos = randi() % 4
	var fourthPos = randi() % 4
	
	while firstPos == secondPos:
		secondPos = randi() % 4
	while thirdPos == firstPos or thirdPos == secondPos:
		thirdPos = randi() % 4
	while fourthPos == firstPos or fourthPos == secondPos or fourthPos == thirdPos:
		fourthPos = randi() % 4
	
	var positions = [0,1,2,3]
	
	positions[0] = firstPos
	positions[1] = secondPos
	positions[2] = thirdPos
	positions[3] = fourthPos
	
	var vecs = [ Vector2(10, 250), Vector2(10, 250), Vector2(10, 250), Vector2(10, 250)]
	
	for num in positions:
		if positions[num] == 0:
			vecs[num] = Vector2(10, 250)
		if positions[num] == 1:
			vecs[num] = Vector2(10, 325)
		if positions[num] == 2:
			vecs[num] = Vector2(10, 400)
		if positions[num] == 3:
			vecs[num] = Vector2(10, 475)
	
	var posCount = 0
		
	for key in linePositions:
		linePositions[key] = vecs[posCount]
		posCount += 1

#Spawns the lines based on the currentLineNum
func setup(lineNum):
	
	randomize_line_positions()
	
	current_lines(lineNum)
	
	for key in currentLines:
		spawn_line(currentLines[key], linePositions[key])

#Spawns the line
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
		
#Checks for what the user is typing
func write_poem(poem):
	if Input.is_action_pressed(currentLines[poem].substr(currentLetterNum[poem], 1)):
		#connect new signal for game reset not just line reset, in the case of adding more rounds
		var letterPos = linePositions[poem]
		letterPos = Vector2(letterPos.x + (spacing * currentLetterNum[poem]), letterPos.y)
		var letter = Letter.instance()
		add_child(letter)
		letter.spawn_letter(currentLines[poem].substr(currentLetterNum[poem], 1))
		connect("kill", letter, "kill_letter")
		letter.add_color_override("font_color", Color(0,0,0))
		letter.rect_position = letterPos
		
		#print("MATCH")
		currentLetterNum[poem] += 1
	elif currentLines[poem].substr(currentLetterNum[poem], 1) == " ":
		currentLetterNum[poem] += 1
	
	if currentLetterNum[poem] == currentLines[poem].length():
		#print("Spawn")
		paintCount[poem] += 1
		currentLetterNum[poem] = 0
		spawn_poem(poem)
		poemLetterPos = Vector2(620, poemLetterPos.y + 100)
		emit_signal("kill")
		currentLineNum += 1
		if currentLineNum < 3:
			setup(currentLineNum)

#Spawns the typed line
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