extends ColorRect

var active_skill_bar = false

func _ready():
	pass 

func _process(delta):
	if active_skill_bar:
		rect_global_position.x += 4
