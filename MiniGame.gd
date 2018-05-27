extends Node

var DialogueChoices = preload("res://GlobalData.gd").DialogueChoices
var GameOutcomes = preload("res://GlobalData.gd").GameOutcomes

func set_points(dialogue_choices):
	pass
	
func is_game_over():
	return false
	
func get_score():
	return 0