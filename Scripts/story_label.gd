extends RichTextLabel

# added modules and twine-story folders
#####CURRENT ISSUES####
# first paragraph is grabbed fine, but the second and onward are not grabbed, text is left blank
## I think this is because the paragraphs get formated all at once, and the newParagraph var is consequently 
## empty after the first time through the Show_paragraph method. Trying to fix this

var DialogueChoices = preload("res://GlobalData.gd").DialogueChoices
var TwineScript = preload("res://modules/twine-story/twine_script.gd")

export(String, FILE, "*.json") var scriptPath

var script
var passage
var originalPassage
var isPlayer = false
var isEnd = false
var cid = 1
var nextDialogueName = ""
var currentParagraph = 0    # will always be 0
var currentSelection = 1  # 3 is for option 1, 4 is for option 2
var depth = 0
var currentDialogue = ""  # 
var dialogue_choice = ""
var activated = false

func _ready():
	script = TwineScript.new(scriptPath)
	script.parse()
	cid = script.get_start_node()
	set_process_input(true)
	print("Story: ", script.get_story_name())
	print("Passage names: ", script.get_passage_names())

func _input(event):
	if activated:
		# increases to the current selection 
		if(event.is_action_pressed("ui_accept")):
			if !isEnd:
				# clear passage so that it doesn't have repeated text
				# change dialogue name to the depth you're at, mark for an NPC, and the option choice the player chose
				passage = ""
				cid += currentSelection + 2
				depth += 2
				nextDialogueName = String(depth) + "N" + String(currentSelection)
				if(show_paragraph(cid, currentParagraph) == false):
					cid -= 1
				if(check_passage(cid, currentParagraph) == 0):
					show_options(cid, currentParagraph)
			elif isEnd:
					print("isEnd")
					activated = false
					currentDialogue = ""
			check_if_end(cid, currentParagraph)
		# changes the option selected between the first and second
		if(!isPlayer):
			passage = ""
			if(event.is_action_pressed("ui_up")):
				currentSelection = 1
				show_paragraph(cid, currentParagraph)
				show_options(cid, currentParagraph)
			if(event.is_action_pressed("ui_down")):
				currentSelection = 2
				show_paragraph(cid, currentParagraph)
				show_options(cid, currentParagraph)

# goes through paragraphs in the current passage and removes anything that isn't inside {}
func show_paragraph(pid, paragraph):
	pid = int(pid)
	print(nextDialogueName)
	for i in script.get_passages().size():
		var val = int(i+1)
		if nextDialogueName in script.get_passage(val).name:
			print("Found the nextDialogueName: ",nextDialogueName)
			passage = script.get_passage(val)
			originalPassage = script.get_passage(val)
			# creates new paragraph to display, and sets the current dialogue.
			# currentDialogue is so that when we try and print it a second time, we can reset the text, 
			# and not get infinite repeating text
			var newParagraph = ""
			var removeText = true
			if '{' in passage.paragraphs[paragraph]:
				for letter in passage.paragraphs[paragraph]:
					if letter == '}':
						removeText = true
						newParagraph += "\n"
					if removeText == false:
						newParagraph = newParagraph + letter
					if letter == '{':
						removeText = false
				passage.paragraphs[paragraph] = newParagraph +"\n"
				currentDialogue = newParagraph +"\n"
			else:
				passage.paragraphs[paragraph] = currentDialogue
	#if(script.has_passage(pid)):
	#	passage = script.get_passage(pid)
	#	originalPassage = script.get_passage(pid)
	#else:
	#	passage = script.get_passage(1)
	#	originalPassage = script.get_passage(pid)
	#	return false
	
	print(passage.paragraphs[paragraph])
	if(paragraph < passage.paragraphs.size()):
		set_bbcode(passage.paragraphs[paragraph])
		return true
	else:
		print("returning false")
		return false

# does the same thing as show_paragraph but is used to show the player dialogue options
func show_options(pid, paragraph):
	var temp = passage.links.keys()
	#print("TEMP SIZE = " + String(passage.links.size()))
	if temp.size() == 0:
		return
	# this will get the passages that the current passage links to
	for keyNum in temp.size():
		var option = script.get_passage(int(passage.links[temp[keyNum]].passageId))
		var newParagraph = ""
		var removeText = true
		if currentSelection == 1 && keyNum == 0:
			newParagraph += '>'
		elif currentSelection == 2 && keyNum == 1:
			newParagraph += '>'
		for letter in option.paragraphs[paragraph]:
			if letter == '}':
				removeText = true
			if removeText == false:
				newParagraph = newParagraph + letter
			if letter == '{':
				removeText = false
		passage.paragraphs[paragraph] += newParagraph +"\n"
		#print(option)
	
	if(paragraph < passage.paragraphs.size()):
		set_bbcode(passage.paragraphs[paragraph])
		return true
	else:
		print("returning false")
		return false

func _on_story_meta_clicked(meta):
	print("Link clicked: ", meta)
	var sectionId = int(meta.split('_')[1])
	cid = sectionId
	currentParagraph = 0
	show_paragraph(cid, currentParagraph)

# check if current selection is a player or NPC and is safe to continue
func check_passage(pid, paragraph):
	if (passage.links.size() > 1):
		if('N' in passage.name):
			#print("Is an NPC")
			isPlayer = false
			return 0
		elif('P' in passage.name):
			#print("Is a player")
			isPlayer = true
			return 1
	else:
		return -1
		
# check if we are on the last sentence of the dialogue
# to check this, we look for either an X - exit, P - play minigame w/o bonuses, 
# S - start minigame w/ bonuses or E - explain, no minigame
func check_if_end(pid, paragraph):
	print(originalPassage.name)
	if ('X' in originalPassage.name):
		print("Has X")
		isEnd = true
		GameManager.handle_dialogue(DialogueChoices.WORST)
	elif ('P' in originalPassage.name):
		print("Has P")
		isEnd = true
		GameManager.handle_dialogue(DialogueChoices.OKAY)
	elif ('S' in originalPassage.name):
		print("Has S")
		isEnd = true
		GameManager.handle_dialogue(DialogueChoices.BETTER)
	elif ('E' in originalPassage.name):
		print("Has E")
		isEnd = true
		GameManager.handle_dialogue(DialogueChoices.BEST)
	else:
		isEnd = false


func _on_IOP_activated():
	#print("Got to the story label")
	if activated != true:
		
		#print("Got to the story label")
		activated = true
		#print(get_node("../../../Camera2D"))
		nextDialogueName = String(depth) + "N" + String(currentSelection)
		rect_position.x = get_node("../../../Camera2D").position.x #- 350
		rect_position.y = get_node("../../../Camera2D").position.y #+ 150
		
		show_paragraph(cid, currentParagraph)
		show_options(cid, currentParagraph)
		if isEnd:
			_on_IOP_exited()


func _on_IOP_exited():
	print("Got Here")
	script = null
	passage = null
	originalPassage = null
	isPlayer = false
	isEnd = false
	cid = 1
	nextDialogueName = ""
	currentParagraph = 0    # will always be 0
	currentSelection = 1  # 3 is for option 1, 4 is for option 2
	depth = 0
	currentDialogue = ""  # 
	dialogue_choice = ""
	activated = false
	_ready()
	rect_position.x = 50000
	rect_position.y = 50000
