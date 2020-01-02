extends Node

const PRE_SPAWN = preload("res://prefabs/spawn_enemy.tscn")
#const init_spawns_x = [-36.044, -79.676, 491.507, 751.175, 1246.08, 1478.94, 1451.62, 717.716, 61.183, -295.157]
#const init_spawns_y = [292.137, -167.223, -220.835, -98.351, -142.605, 203.431, 848.962, 724.768, 801.068, 668.656] 
#
#var spawns_used = []

func _ready():
	GAME.connect("generation_new_spawn", self, "on_new_spawn")
#	for i in range(5):
#		new_spawn()
#
#func new_spawn():
#	var pos = get_init_position()
#
#	var spawn = PRE_SPAWN.instance()
#	spawn.global_position = Vector2(init_spawns_x[pos], init_spawns_y[pos])
#	add_child(spawn)
#
#func get_init_position():
#	var pos	
#	var spawns_used_size = spawns_used.size()
#
#	while(true):
#		var exist = false
#		pos = randi() % 10
#		for i in range(spawns_used_size):
#			if spawns_used[i] == pos:
#				exist = true
#		if !exist:
#			break
#	spawns_used.append(pos)
#	return pos

func on_new_spawn():
#	new_spawn()
	var spawn = PRE_SPAWN.instance()
	spawn.global_position = spawn.new_position()
	add_child(spawn)





