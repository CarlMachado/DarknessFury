extends Position2D

const PRE_ENEMY = preload("res://prefabs/enemy.tscn")

func _ready():
	pass 
	
func _process(delta):
	pass

func _on_timer_spawn_timeout():
	var enemy = PRE_ENEMY.instance() 
	enemy.global_position = global_position
	$"../".add_child(enemy)
	
