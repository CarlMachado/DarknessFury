extends Node2D

var cur_frame = 0
var stage = 0

func _ready():
	pass

func initial_animation():
	cur_frame += 1
	
	if cur_frame > 50 and $player_down.frame < 3:
		$player_down.frame += 1
		cur_frame = 0
	elif cur_frame > 50 and $player_down.frame == 3:
		$player_down.hide()
		$player.show()
	
	if stage == 0 and cur_frame > 100:
		stage += 1
		pass
	
	if cur_frame > 100:
		$speak_ballon.show()
		cur_frame = 0

func _process(delta):
	initial_animation()