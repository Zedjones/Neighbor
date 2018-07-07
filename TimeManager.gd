extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum Day { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }

var currentDay = Day.Monday
var currentTime

func next_day():
	currentDay += 1; 
	pass

func get_current_day():
	return currentDay
