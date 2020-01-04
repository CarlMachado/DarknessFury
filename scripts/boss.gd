extends KinematicBody2D

const PRE_SPEAR = preload("res://prefabs/spear_hand_boss.tscn")
const DEATH_ZONE_ANGLE = .01
const ROT_VEL = 1

var alive = true

var loaded = true
#var bodys = []
var vel = rand_range(40, 60)
var body_
var boss_dialogue = true

func _ready():
	boss_dialogue = true
	# warning-ignore:return_value_discarded
	$area_damage.connect("hitted", self, "on_area_hitted") # warning-ignore:return_value_discarded
	$area_damage.connect("destroid", self, "on_area_destroid")

func _physics_process(delta):
	if alive and !boss_dialogue:
		if !GAME.player_live:
			body_ = null
		
		if loaded and body_ != null and GAME.player_live:
			var correct	
			if global_position.distance_to(body_.global_position) > 300:
				correct = 0.05
			elif global_position.distance_to(body_.global_position) > 600:
				correct = 0.020
			else:
				correct = 0.175
			var spear_attack = PRE_SPEAR.instance()
			spear_attack.global_position = $spear.global_position / 2
			spear_attack.rotation = global_rotation
			spear_attack.dir = Vector2(cos(rotation + correct), sin(rotation + correct))
			spear_attack.target = body_
			spear_attack.type = "enemy_attack"
			get_parent().add_child(spear_attack)
			$spear.hide()
			loaded = false
			var timer_reload = rand_range(1.5, 2.25)
			$reload.start(timer_reload) # atirar
			$reload_weapon.start(rand_range(timer_reload - 1.5, timer_reload - 0.75)) # exibir arma
#			$reload.start(40)
#			$reload_weapon.start(40)
		if body_ != null:
			var angle = get_angle_to(body_.global_position)
			if abs(angle) > DEATH_ZONE_ANGLE:
				rotation += sign(angle) * delta * ROT_VEL

func boss_dialogue_change():
	boss_dialogue = false

func autodestroy():
	alive = false
	$area_damage.queue_free()
	$reload.queue_free()
	$reload_weapon.queue_free()
	$anim_sprite.queue_free()
	$spear.queue_free()
	$particles_dead.emitting = true
#	$anim.play("dead")
#	yield($anim, "animation_finished")
	GAME.win()
	yield(get_tree().create_timer(2), "timeout")
	queue_free()

func boss_self():
	pass

func _on_sensor_body_entered(body):
	if body.has_method("player_self"):
		body_ = body
		$sensor.queue_free()

func _on_reload_timeout():
	loaded = true
	$reload.stop()

func _on_reload_weapon_timeout():
	$reload_weapon.stop()
	$spear.show()
	
func on_area_hitted():
	$hurt.play()
	$particles_hit.emitting = true

func on_area_destroid():
	$death.play()
	autodestroy()
