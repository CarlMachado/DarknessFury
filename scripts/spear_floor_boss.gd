extends Area2D

var has_spear = false

func _ready():
	scale = scale / 2
	global_position = global_position / 2
	$hit_floor.play()
	$anim.play("destroy_spear")

func spear_true():
	has_spear = true

func spear_false():
	has_spear = false

# warning-ignore:unused_argument
func _on_spear_body_entered(body):
	if not has_spear:
		get_tree().call_group("player", "take_spear")
		queue_free()

#func _on_timer_timeout():
#	queue_free()

func _on_timer_dead_timeout():	
	queue_free()