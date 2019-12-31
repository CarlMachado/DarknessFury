extends Position2D

const PRE_ENEMY = preload("res://prefabs/enemy.tscn")

var enemy
var firt_start = false

onready var time_min = 4
onready var time_max = 7

func _ready():
	$timer_spawn.start(rand_range(time_min, time_max))
#	$timer_spawn.start(1) 
	
func _process(delta):
	if enemy == null and !firt_start:
		enemy = PRE_ENEMY.instance() 
		enemy.global_position = global_position
		$"../".add_child(enemy)
		
		firt_start = true
		$timer_spawn.stop()

func dead_enemy():
	if enemy != null:
		if !enemy.alive:
			enemy = null
			$timer_spawn.start(rand_range(time_min, time_max))

func _on_timer_spawn_timeout():
	enemy = PRE_ENEMY.instance() 
	enemy.global_position = global_position
	$"../".add_child(enemy)
	
	$timer_spawn.stop()
	
func _on_walls_area_body_entered(body):
	if body.has_method("stop_in_area"):
		body.stop_in_area()
