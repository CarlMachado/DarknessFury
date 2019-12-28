extends KinematicBody2D

const SPEED = 200

var pre_spear = preload("res://prefabs/spear_hand.tscn")

func _ready():
	add_to_group("player")
	pass

func _process(delta):
	pass

func _physics_process(delta):
	var x_dir = 0
	var y_dir = 0
	
	if Input.is_action_pressed("ui_right"):
		x_dir += 1
		$anim_sprite.play("walk")
	if Input.is_action_pressed("ui_left"):
		x_dir -= 1
		$anim_sprite.play("walk")
	if Input.is_action_pressed("ui_up"):
		y_dir -= 1
		$anim_sprite.play("walk")
	if Input.is_action_pressed("ui_down"):
		y_dir += 1
		$anim_sprite.play("walk")
	
	if not Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		$anim_sprite.play("idle")
		
	look_at(get_global_mouse_position())
	
	move_and_slide(Vector2(x_dir, y_dir) * SPEED)

func take_spear():
	var spear = pre_spear.instance()
	spear.global_position = global_position
	spear.z_index = z_index + 1
	add_child(spear)