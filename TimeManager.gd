extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum Day { Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday }
var storyManager = preload("res://Scripts/story_label.gd")

var currentDay = Day.Monday
var currentTime
var day
var time

func _ready():
	day = get_node("/root/World/Camera2D/Day")
	time = get_node("/root/World/Camera2D/Time")

func next_day():
	currentDay = currentDay + 1
	storyManager._on_IOP_exited()
	day.text = String(Day.Tuesday)
	pass

func get_current_day():
	return currentDay
