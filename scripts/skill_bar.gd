extends Node2D

func _ready():
	self.hide() 
	pass

func _process(delta):
	pass
#	if active_skill_bar:
#		self.skill_bar_green.queue_free()

func active():
	self.show()
	
func desactive():
	self.hide()