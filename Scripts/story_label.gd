extends RichTextLabel

# added modules and twine-story folders
#####CURRENT ISSUES####
# first paragraph is grabbed fine, but the second and onward are not grabbed, text is left blank
## I think this is because the paragraphs get formated all at once, and the newParagraph var is consequently 
## empty after the first time through the Show_paragraph method. Trying to fix this

var TwineScript = preload("res://modules/twine-story/twine_script.gd")

export(String, FILE, "*.json") var scriptPath

var script
var passage
var isPlayer = false
var currentPassage = 1
var currentParagraph = 0
var currentSelection = 1
var currentDialogue = ""
var dialogueEnabled = false
func _ready():
	script = TwineScript.new(scriptPath)
	script.parse()
	currentPassage = script.get_start_node()
	
	show_paragraph(currentPassage, currentParagraph)
	show_options(currentPassage, currentParagraph)

	set_process_input(true)
	print("Story: ", script.get_story_name())
	print("Passage names: ", script.get_passage_names())

func format_passages(pid,paragraph):
	return

func _input(event):
	if(dialogueEnabled):
		if(event.is_action_pressed("ui_accept")):
			passage = ""
			currentPassage += currentSelection
			if(show_paragraph(currentPassage, currentParagraph) == false):
				currentPassage -= 1
			if(check_passage(currentPassage, currentParagraph) == 0):
				show_options(currentPassage, currentParagraph)
		if(!isPlayer):
			passage = ""
			if(event.is_action_pressed("ui_up")):
				currentSelection = 3
				show_paragraph(currentPassage, currentParagraph)
				show_options(currentPassage, currentParagraph)
			if(event.is_action_pressed("ui_down")):
				currentSelection = 4
				show_paragraph(currentPassage, currentParagraph)
				show_options(currentPassage, currentParagraph)

# goes through paragraphs in the current passage and removes anything that isn't inside {}
func show_paragraph(pid, paragraph):
	pid = int(pid)
	if(script.has_passage(pid)):
		passage = script.get_passage(pid)
	else:
		passage = script.get_passage(1)
		return false
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
	
	if(paragraph < passage.paragraphs.size()):
		set_bbcode(passage.paragraphs[paragraph])
		return true
	else:
		print("returning false")
		return false

# does the same thing as show_paragraph but is used to show the player dialogue options
func show_options(pid, paragraph):
	var temp = passage.links.keys()
	# this will get the passages that the current passage links to
	var optionOneId = script.get_passage(int(passage.links[temp[0]].passageId))
	var optionTwoId = script.get_passage(int(passage.links[temp[1]].passageId))
	var newParagraph = ""
	var removeText = true
	if currentSelection == 3:
		newParagraph += '>'
	for letter in optionOneId.paragraphs[paragraph]:
		if letter == '}':
			removeText = true
		if removeText == false:
			newParagraph = newParagraph + letter
		if letter == '{':
			removeText = false
	
	passage.paragraphs[paragraph] += newParagraph +"\n"
	newParagraph = ""
	if currentSelection == 4:
		newParagraph += '>'
	for letter in optionTwoId.paragraphs[paragraph]:
		if letter == '}':
			removeText = true
		if removeText == false:
			newParagraph = newParagraph + letter
		if letter == '{':
			removeText = false
	passage.paragraphs[paragraph] += newParagraph +"\n"
	
	if(paragraph < passage.paragraphs.size()):
		set_bbcode(passage.paragraphs[paragraph])
		return true
	else:
		print("returning false")
		return false

func _on_story_meta_clicked(meta):
	print("Link clicked: ", meta)
	var sectionId = int(meta.split('_')[1])
	currentPassage = sectionId
	currentParagraph = 0
	show_paragraph(currentPassage, currentParagraph)

# check if current selection is a player or NPC
func check_passage(pid, paragraph):
	if(passage.links.size() > 1):
		if('N' in passage.name):
			print("Is an NPC")
			isPlayer = false
			return 0
		elif('P' in passage.name):
			print("Is a player")
			isPlayer = true
			return 1
	else:
		return -1

func go_to_next_passage(pid, paragraph):
	