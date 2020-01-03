extends KinematicBody2D

const PRE_SPEAR = preload("res://prefabs/spear_hand.tscn")
const DEATH_ZONE_ANGLE = .01
const ROT_VEL = 1

var homming = false
var alive = true

var loaded = true
#var bodys = []
var vel = rand_range(40, 60)
var body_

func _ready():
	add_to_group("enemy")
	GAME.enemys_spawn += 1
	# warning-ignore:return_value_discarded
	$area_damage.connect("hitted", self, "on_area_hitted") # warning-ignore:return_value_discarded
	$area_damage.connect("destroid", self, "on_area_destroid")
	yield(get_tree().create_timer(60), "timeout")
	homming = true

func _physics_process(delta):
	if alive:
		if !GAME.player_live:
			body_ = null
		
		if !homming:
			# warning-ignore:return_value_discarded
			move_and_slide(Vector2(cos(rotation), sin(rotation)) * vel)
		else:
			if loaded and body_ != null and GAME.player_live:
				var correct	
				if global_position.distance_to(body_.global_position) > 300:
					correct = 0.05
				elif global_position.distance_to(body_.global_position) > 600:
					correct = 0.020
				else:
					correct = 0.175
				var spear_attack = PRE_SPEAR.instance()
				spear_attack.global_position = $spear.global_position
				spear_attack.rotation = global_rotation
				spear_attack.dir = Vector2(cos(rotation + correct), sin(rotation + correct))
				spear_attack.target = body_
				spear_attack.type = "enemy_attack"
				spear_attack.scale = spear_attack.scale * 2
				get_parent().add_child(spear_attack)
				$spear.hide()
				loaded = false
				$reload.start(rand_range(3.0, 3.75))
				$reload_weapon.start(rand_range(2.25, 3.00))
#				$reload.start(40)
#				$reload_weapon.start(40)
		if body_ != null:
			var angle = get_angle_to(body_.global_position)
			if abs(angle) > DEATH_ZONE_ANGLE:
				rotation += sign(angle) * delta * ROT_VEL
	
func autodestroy():
	alive = false
	get_tree().call_group("spawn", "dead_enemy")	
	get_tree().call_group("spawn", "change_timer_spawn")	
	GAME.add_kill()
	$area_damage.queue_free()
	$reload.queue_free()
	$reload_weapon.queue_free()
	$anim_sprite.queue_free()
	$spear.queue_free()
	$particles_dead.emitting = true
	$anim.play("dead")
	yield($anim, "animation_finished")
	remove_from_group("enemy")
	queue_free()

func stop_in_area():
	homming = true
	
func _on_sensor_body_entered(body):
	body_ = body
	$sensor.queue_free()
	#bodys.append(body)

#func _on_sensor_body_exited(body):
#	var index = bodys.find(body)
#	if index >= 0:
#		bodys.remove(index)

func _on_reload_timeout():
	loaded = true
	$reload.stop()

func _on_reload_weapon_timeout():
	$reload_weapon.stop()
	$spear.show()
	
func on_area_hitted():
	pass

func on_area_destroid():
	autodestroy()
	pass
