extends Node

var DialogueChoices = preload("res://GlobalData.gd").DialogueChoices
var GameOutcomes = preload("res://GlobalData.gd").GameOutcomes

var curr_character
var time_manager
var dialogue_manager
var in_mini_game = false
var mini_game
var dialogue_choice

const HAPPINESS_BASE = 5
const BETTER_MULT = 1.2

func _ready():
	pass
	
func _process(delta):
	# if the player is currently in a mini-game
	if in_mini_game:
		if mini_game.is_game_over():
			in_mini_game = false
			var score = mini_game.get_score()
			# adjust based on the outcome being better or worse and the dialogue choice 
			match score:
				GameOutcomes.BETTER:
					curr_character.adjust_happiness(dialogue_choice*BETTER_MULT*HAPPINESS_BASE)
				GameOutcomes.WORSE:
					curr_character.adjust_happiness(dialogue_choice*HAPPINESS_BASE)
			SceneManager.unload_scene()
			mini_game = null
			dialogue_choice = null

# Set the current character, would be called when player moves into character's 
# space
# @param character - the character object to set as current
func set_curr_character(character):
	# since this is called constantly when in player space, check if not already set
	if curr_character != character:
		curr_character = character
		# if not passed in null, call dialogue_manager prompt 
		if character != null:
			#dialogue_manager.prompt(character)
			pass
			
func start_mini_game():
	if(curr_character != null):
		#print("Yes curr_character")
		if(curr_character.mini_game != null):
			#print("Yes mini_game")	
			var mg = curr_character.mini_game
			in_mini_game = true
			dialogue_choice = DialogueChoices.BEST
			mini_game = SceneManager.load_scene(mg)
			
		#else:
	#		print("No mini_game")
	#else:
	#	print("No curr_character")
			

# Handle the dialogue choice made by the player, passed in by the Dialogue Manager
# @param dialogue_choice - a DialogueChoice enum
func handle_dialogue(dialogue_choice):
	var mg = curr_character.mini_game
	
	match dialogue_choice:
		DialogueChoices.WORST:
			pass
		DialogueChoices.OKAY:
			#mg.set_points(DialogueChoices.OKAY)
			mini_game = SceneManager.load_scene(mg, dialogue_choice)
			in_mini_game = true
			self.dialogue_choice = dialogue_choice
		DialogueChoices.BETTER:
			curr_character.adjust_happiness(DialogueChoices.BETTER*HAPPINESS_BASE)
		DialogueChoices.BEST:
			#mg.set_points(DialogueChoices.BEST)
			mini_game = SceneManager.load_scene(mg, dialogue_choice)
			in_mini_game = true
			self.dialogue_choice = dialogue_choice