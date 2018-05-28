extends Node

var DialogueChoices = preload("res://GlobalData.gd").DialogueChoices
var GameOutcomes = preload("res://GlobalData.gd").GameOutcomes

# GameManager or Character will call this to talk to mini-game
# @param dialogue_choices - a DialogueChoices enum item 
func set_points(dialogue_choices):
	pass
	
# Whether or not the game is complete 
func is_game_over():
	return false
	
# GameManager will call this to get the outcome from the mini-game
# @return - a GameOutcomes enum item
func get_score():
	return GameOutcomes.BETTER