extends Position2D

const PRE_ENEMY = preload("res://prefabs/enemy.tscn")

var enemy
var firt_start = false

func _ready():
	$timer_spawn.start(rand_range(4, 7))
#	$timer_spawn.start(1) 
	
func _process(delta):
	if enemy == null and !firt_start:
		enemy = PRE_ENEMY.instance() 
		enemy.global_position = global_position
		$"../".add_child(enemy)
		
		firt_start = true
		$timer_spawn.stop()

func dead_enemy():
	if !enemy.alive:
		$timer_spawn.start(rand_range(4, 7))

func _on_timer_spawn_timeout():
	enemy = PRE_ENEMY.instance() 
	enemy.global_position = global_position
	$"../".add_child(enemy)
	
	$timer_spawn.stop()
	
func _on_walls_area_body_entered(body):
	if body.has_method("stop_in_area"):
		body.stop_in_area()
