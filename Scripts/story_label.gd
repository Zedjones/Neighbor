extends RichTextLabel

# added modules and twine-story folders
#####CURRENT ISSUES####
# first paragraph is grabbed fine, but the second and onward are not grabbed, text is left blank
## I think this is because the paragraphs get formated all at once, and the newParagraph var is consequently 
## empty after the first time through the Show_paragraph method. Trying to fix this

var TwineScript = preload("res://modules/twine-story/twine_script.gd")

export(String, FILE, "*.json") var scriptPath

var script
var currentPassage = 1
var currentParagraph = 0

func _ready():
	script = TwineScript.new(scriptPath)
	script.parse()
	currentPassage = script.get_start_node()
	
	show_paragraph(currentPassage, currentParagraph)

	set_process_input(true)
	print("Story: ", script.get_story_name())
	print("Passage names: ", script.get_passage_names())

func _input(event):
	if(event.is_action_pressed("ui_accept")):
		currentPassage += 1
		if(!show_paragraph(currentPassage, currentParagraph)):
			currentPassage -= 1

func show_paragraph(pid, paragraph):
	var passage
	pid = int(pid)
	if(script.has_passage(pid)):
		passage = script.get_passage(pid)
	else:
		passage = script.get_passage(1)
		print("Shouldn't be here")
		return false
	var newParagraph = ""
	var removeText = true
	for letter in passage.paragraphs[paragraph]:
		if letter == '}':
			removeText = true
			newParagraph += "\n"
		if removeText == false:
			newParagraph = newParagraph + letter
		if letter == '{':
			removeText = false
	passage.paragraphs[paragraph]= newParagraph +"\n"
	print("Current passage printing")
	print(passage.paragraphs[paragraph])
	
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