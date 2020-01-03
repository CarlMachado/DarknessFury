extends Node2D

func _ready():
	self.hide() 
	pass

func active():
	$start.play()
	self.show()
	
func desactive():
	self.hide()
	
func destroy():
	if !GAME.player_live:
		queue_free()