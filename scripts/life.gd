extends Node2D

const LIFE_STATE_MIN = 1
const LIFE_STATE_MAX = 4

func _ready():
	$sprite_state1.show()
	$sprite_state2.hide()
	$sprite_state3.hide()
	$sprite_state4.hide()

# warning-ignore:unused_argument
func _process(delta):
	pass
	
func change_state(life_state):
	if life_state >= LIFE_STATE_MIN and life_state <= LIFE_STATE_MAX:
		var new_life = "sprite_state" + str(life_state)
		var old_life = "sprite_state" + str(life_state - 1)
		get_node(new_life).show()
		get_node(old_life).hide()