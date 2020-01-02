extends KinematicBody2D

const PRE_SPEAR = preload("res://prefabs/spear_hand.tscn")
const SPEED = 200

var time_out = false
var has_spear = false
var loaded = true
var active_skill_bar = false
var start_dead = false
var action_answer # alvo verde - 1 / alvo vermelho - 0
var life_state = 1

enum {ATTACK, SKILL}
var atk_status = ATTACK

enum {PLAYING, DEAD, BOSS, RESTART}
var status = PLAYING

func _ready():
	$area_hit.connect("hitted", self, "on_area_hitted")
	$area_hit.connect("destroid", self, "on_area_destroid")
	GAME.player_live = true

func _physics_process(delta):
	if status == PLAYING:
		playing(delta)
	elif status == DEAD:
		dead(delta)
	elif status == BOSS:
		boss(delta)

func boss(delta):
	get_tree().call_group("arena", "init_boss")

func playing(delta):
	var x_dir = 0
	var y_dir = 0
	
	if Input.is_action_pressed("ui_right"):
		x_dir += 1
	if Input.is_action_pressed("ui_left"):
		x_dir -= 1
	if Input.is_action_pressed("ui_up"):
		y_dir -= 1
	if Input.is_action_pressed("ui_down"):
		y_dir += 1
	
	if not Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		$anim_sprite.play("idle")
		$particles_floor.emitting = false
	else:
		$anim_sprite.play("walk")
		$particles_floor.emitting = true
	
	if Input.is_action_just_pressed("ui_attack") and atk_status == ATTACK:
		init_shoot_spear()
		atk_status = SKILL
	elif Input.is_action_just_pressed("ui_attack") and atk_status == SKILL: 
		skill()
		atk_status = ATTACK
	
	if has_spear:
		$spear_hand.show()
	else:
		$spear_hand.hide()
	
	look_at(get_global_mouse_position())
	move_and_slide(Vector2(x_dir, y_dir) * SPEED)
	
func dead(delta):
	if !start_dead:
		GAME.player_live = false
		$particles_floor.emitting = false
		get_tree().call_group("skill_bar", "destroy")
		GAME.restart()
		$particles_floor.queue_free()
		$area_hit.queue_free()
		$shape.queue_free()
		$spear_hand.queue_free()
		$anim_sprite.play("dead")
		$particles_dead.emitting = true
		start_dead = true
	
	if Input.is_action_pressed("ui_accept"):
		restart()

func restart():
	status = RESTART
	get_tree().call_group("Menu", "_on_jogar_pressed")
	queue_free()

func skill():
	if active_skill_bar:		
		get_tree().call_group("skill_bar", "action")

func time_out_boss():
	time_out = true
	
	print("time out")

func finish_skill():
	action_answer = null
	active_skill_bar = false
	get_tree().call_group("skill_bar", "desactive")

func init_shoot_spear():
	if has_spear:
		active_skill_bar = true
		get_tree().call_group("skill_bar", "active")

func shoot_spear():
	if has_spear and loaded and active_skill_bar and action_answer != null:
		get_tree().call_group("spear", "spear_false")
		
		var position_mouse = global_position.distance_to(get_global_mouse_position())
		var angle = atan2(get_global_mouse_position().y - global_position.y, get_global_mouse_position().x - global_position.x)
		var correct = 0
		
		if action_answer == 1: # alvo verde
			correct = 0.2792664417184 - 0.037934649586 * log(position_mouse)
		else:
			pass
			
		var spear_attack = PRE_SPEAR.instance()	
		spear_attack.global_position = $spear_hand.global_position / 2
		spear_attack.rotation = global_rotation
		spear_attack.dir = Vector2(cos(angle - correct), sin(angle - correct))
		spear_attack.target_position = get_global_mouse_position()
		spear_attack.type = "player_attack"
		get_parent().add_child(spear_attack)
		
		finish_skill()
		has_spear = false
		loaded = false
		$reload.start()
		GAME.unload()

func take_spear():
	get_tree().call_group("spear", "spear_true")
	if not has_spear:
#		$anim_sprite.play("take_weapon")
		has_spear = true
	GAME.reload(loaded, has_spear)

func _on_reload_timeout():
	$reload.stop()
	loaded = true
	GAME.reload(loaded, has_spear)
	
func on_area_hitted(damage, health, node):
	life_state += 1
	get_tree().call_group("life_HUD", "change_state", life_state)
	pass

func on_area_destroid():
	if time_out:
		status = BOSS
	else:
		status = DEAD
	
func skill_action(action):
	self.action_answer = action
	shoot_spear()
