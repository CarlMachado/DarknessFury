extends Node2D

var enemy = []

func _ready():
	# da start nos timers
	
	for i in range(9):
		var spawn_en = 'enemy_spawns/spawn_enemy' + str(i) + '/timer_spawn'
		get_node(spawn_en).start(1)
	
#	$enemy_spawns/spawn_up_left/timer_ul.start(cooldown[0])
#	$enemy_spawns/spawn_up_right/timer_ur.start(cooldown[1])
#	$enemy_spawns/spawn_right_up/timer_ru.start(cooldown[2])
#	$enemy_spawns/spawn_right_down/timer_rd.start(cooldown[3])
#	$enemy_spawns/spawn_down_right/timer_dr.start(cooldown[4])
#	$enemy_spawns/spawn_down_midle/timer_dm.start(cooldown[5])
#	$enemy_spawns/spawn_down_left/timer_dl.start(cooldown[6])
#	$enemy_spawns/spawn_left_down/timer_ld.start(cooldown[7])
#	$enemy_spawns/spawn_left_up/timer_lu.start(cooldown[8])
	
	# inicializa os inimigos
#	enemy.append(pre_enemy.instance())
#	enemy[0].global_position = $enemy_spawns/spawn_up_left.global_position
#	$"../".add_child(enemy[0])
#	enemy.append(pre_enemy.instance())
#	enemy[1].global_position = $enemy_spawns/spawn_up_right.global_position
#	$"../".add_child(enemy[1])
#	enemy.append(pre_enemy.instance())
#	enemy[2].global_position = $enemy_spawns/spawn_right_up.global_position
#	$"../".add_child(enemy[2])
#	enemy.append(pre_enemy.instance())
#	enemy[3].global_position = $enemy_spawns/spawn_right_down.global_position
#	$"../".add_child(enemy[3])
#	enemy.append(pre_enemy.instance())
#	enemy[4].global_position = $enemy_spawns/spawn_down_right.global_position
#	$"../".add_child(enemy[4])
#	enemy.append(pre_enemy.instance())
#	enemy[5].global_position = $enemy_spawns/spawn_down_midle.global_position
#	$"../".add_child(enemy[5])
#	enemy.append(pre_enemy.instance())
#	enemy[6].global_position = $enemy_spawns/spawn_down_left.global_position
#	$"../".add_child(enemy[6])
#	enemy.append(pre_enemy.instance())
#	enemy[7].global_position = $enemy_spawns/spawn_left_down.global_position
#	$"../".add_child(enemy[7])
#	enemy.append(pre_enemy.instance())
#	enemy[8].global_position = $enemy_spawns/spawn_left_up.global_position
#	$"../".add_child(enemy[8])

func _process(delta):
	pass
	# faz os inimigos mirarem o player
#	enemy[0].look_at($player.global_position)
#	enemy[1].look_at($player.global_position)
#	enemy[2].look_at($player.global_position)
#	enemy[3].look_at($player.global_position)
#	enemy[4].look_at($player.global_position)
#	enemy[5].look_at($player.global_position)
#	enemy[6].look_at($player.global_position)
#	enemy[7].look_at($player.global_position)
#	enemy[8].look_at($player.global_position)

# sinais
func _on_timer_ul_timeout():
	# se o inimigo estiver morto ele renasce 
	pass
#	if not enemy[0].alive:
#		$"../".remove_child(enemy[0])
#		enemy[0] = pre_enemy.instance()
#		enemy[0].global_position = $enemy_spawns/spawn_up_left.global_position
#		$"../".add_child(enemy[0])
