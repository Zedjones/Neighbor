extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal on_day_changed

enum Day { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }
var storyManager = preload("res://Scripts/story_label.gd")

var currentDay = Day.Monday
var currentTime
var day
var time

func _ready():
	day = get_node("/root/World/CanvasLayer/Day")
	time = get_node("/root/World/CanvasLayer/Time")

func next_day():
	currentDay = currentDay + 1
	
#	storyManager._on_IOP_exited()
	day.text = day_to_string(currentDay)
	emit_signal("on_day_changed")

func get_current_day():
	return currentDay

func day_to_string(day):
	match day:
		Day.Monday:
			return "Monday"
		Day.Tuesday:
			return "Tuesday"
		Day.Wednesday:
			return "Wednesday"
		Day.Thursday:
			return "Thursday"
		Day.Friday:
			return "Friday"
		Day.Saturday:
			return "Saturday"
		Day.Sunday:
			return "Sunday"
	
	return day