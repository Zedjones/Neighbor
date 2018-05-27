extends Area2D


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Bottom_area_entered(area):
	print(area)

func _on_Bottom_body_entered(body):
	print(body)
