extends Node

export (PackedScene) var Letter

func _ready():
	$Paintings/Sun.frame = 0
	$Paintings/Star.frame = 4
	$Paintings/Fire.frame = 8
	$Paintings/Candle.frame = 12
	pass

func _process(delta):
	
	if $Paintings/Sun.frame < 3:
		$Paintings/Sun.frame += 1
	else:
		$Paintings/Sun.frame = 0
	
	
	if $Paintings/Star.frame < 7:
		$Paintings/Star.frame += 1
	else:
		$Paintings/Star.frame = 4
	
	
	if $Paintings/Fire.frame < 11:
		$Paintings/Fire.frame += 1
	else:
		$Paintings/Fire.frame = 8
	
	
	if $Paintings/Candle.frame < 15:
		$Paintings/Candle.frame += 1
	else:
		$Paintings/Candle.frame = 12
	
	pass
