extends Node2D

func _ready():
	self.hide() 
	pass

func _process(delta):
	pass

func active():
	self.show()
	
func desactive():
	self.hide()