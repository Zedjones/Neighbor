extends Node

export (PackedScene) var Cat
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here

	pass
	
	# choose a random location on Path2
    # $MobPath/MobSpawnLocation.set_offset(randi())
    # create a Mob instance and add it to the scene
    #var mob = Mob.instance()
    #add_child(mob)
    # set the mob's direction perpendicular to the path direction
    #var direction = $MobPath/MobSpawnLocation.rotation + PI/2
    # set the mob's position to a random location
    #mob.position = $MobPath/MobSpawnLocation.position
    # add some randomness to the direction
   # direction += rand_range(-PI/4, PI/4)
    #mob.rotation = direction
    # choose the velocity
    #mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_CatSpawnTimer_timeout():
	
	var cat = Cat.instance()
	
	var position
	var vel = Vector2(0, 0)
	randomize()
	if(randf() > 0.5):
		$LeftSide/LeftPathFollow.set_offset(randi())
		position = $LeftSide/LeftPathFollow.position
		cat.set_linear_velocity(Vector2(cat.MAX_SPEED * cat.speedMod, 0))
#		cat.set_linear_velocity(Vector2(100, 0))
		
		#cat.flip_h = true;
		
	else:
		$RightSide/RightPathFollow.set_offset(randi())
		position = $RightSide/RightPathFollow.position
		cat.set_linear_velocity(Vector2(-1 * cat.MAX_SPEED * cat.speedMod, 0))
		#cat.set_linear_velocity(Vector2(-1* 100, 0))
		

		
		
	cat.position = position
	
	add_child(cat)
		
	pass # replace with function body
