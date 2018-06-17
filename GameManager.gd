extends Node

var DialogueChoices = preload("res://GlobalData.gd").DialogueChoices
var GameOutcomes = preload("res://GlobalData.gd").GameOutcomes
var curr_character
var scene_manager
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
	if in_mini_game:
		if mini_game.is_game_over():
			in_mini_game = false
			var score = mini_game.get_score()
			match score:
				GameOutcomes.BETTER:
					curr_character.adjust_happiness(dialogue_choice*BETTER_MULT*HAPPINESS_BASE)
				GameOutcomes.WORSE:
					curr_character.adjust_happiness(dialogue_choice*HAPPINESS_BASE)
			mini_game = null
			dialogue_choice = null

func set_curr_character(character):
	if curr_character != character:
		curr_character = character
		if character != null:
			#dialogue_manager.prompt(character)
			pass

func handle_dialogue(dialogue_choice):
	mini_game = curr_character.mini_game
	match dialogue_choice:
		DialogueChoices.Worst:
			pass
		DialogueChoices.Okay:
			mini_game.set_points(DialogueChoices.Okay)
			scene_manager.loadScene(mini_game)
			in_mini_game = true
			self.dialogue_choice = dialogue_choice
		DialogueChoices.Better:
			curr_character.adjust_happiness(DialogueChoices.Better*HAPPINESS_BASE)
		DialogueChoices.Best:
			mini_game.set_points(DialogueChoices.Best)
			scene_manager.loadScene(mini_game)
			in_mini_game = true
			self.dialogue_choice = dialogue_choice