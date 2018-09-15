extends Sprite
 
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
 
func _ready():
    # Called when the node is added to the scene for the first time.
    # Initialization here
    pass
 
func _process(delta):
#   # Called every frame. Delta is time since last frame.
#   # Update game logic here.
    var total = 0
    var count = $"../../Characters".get_child_count()
    for character in $"../../Characters".get_children():
        total += character.happiness
    var average = total / count
    material.set_shader_param("happiness_scale", 1-((average)/100))