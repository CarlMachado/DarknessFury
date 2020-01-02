extends Position2D

const PRE_ENEMY = preload("res://prefabs/enemy.tscn")

export(int, "Cima", "Direita", "Baixo", "Esquerda") var side = 0

var enemy
var firt_start = false
var player_live = true

onready var time_min = 4
onready var time_max = 7

func _ready():
	randomize()
#	new_position()
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
		if !enemy.alive and GAME.player_live:
			enemy = null
			new_position()
			$timer_spawn.start(rand_range(time_min, time_max))

func _on_timer_spawn_timeout():
	enemy = PRE_ENEMY.instance() 
	enemy.global_position = global_position
	$"../".add_child(enemy)
	
	$timer_spawn.stop()
	
func _on_walls_area_body_entered(body):
	if body.has_method("stop_in_area"):
		body.stop_in_area()

func new_position():
	var tile_size = 32
	var side_coords = [] #x_min, x_max, y_min, y_max
	side = randi() % 4
	
#	if side == 0: # Cima
#		side_coords = [0 * tile_size, 19 * tile_size, -5 * tile_size, 0 * tile_size]
#	elif side == 1: # Direita
#		side_coords = [19 * tile_size, 24 * tile_size, 0 * tile_size, 10 * tile_size]
#	elif side == 2: # Baixo
#		side_coords = [0 * tile_size, 19 * tile_size, 10 * tile_size, 15 * tile_size]
#	elif side == 3: # Esquerda
#		side_coords = [-5 * tile_size, 0 * tile_size, 0 * tile_size, 10 * tile_size]
		
	if side == 0: # Cima
		side_coords = [0, 1300, -320, 0]
	elif side == 1: # Direita
		side_coords = [1280, 1600, 0, 700]
	elif side == 2: # Baixo
		side_coords = [0, 1300, 700, 1050]
	elif side == 3: # Esquerda
		side_coords = [-300, 0, 0, 700]

	var position =  Vector2(rand_range(side_coords[0], side_coords[1]), rand_range(side_coords[2], side_coords[3]))
	$".".global_position = position
	return position
	
func change_timer_spawn():
	time_min -= rand_range(0.10 / GAME.KILLS_INCREMENT, 0.50 / GAME.KILLS_INCREMENT)
	time_max -= rand_range(0.25 / GAME.KILLS_INCREMENT, 0.75 / GAME.KILLS_INCREMENT)
	
	
	
	
	
	