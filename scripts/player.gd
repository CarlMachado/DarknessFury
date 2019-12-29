extends KinematicBody2D

const MAX_LIFE = 100
const SPEED = 200

var life = MAX_LIFE
var has_spear = false

func _ready():
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
	
	if Input.is_action_just_pressed("ui_attack"):
		print("matar")
		get_tree().call_group("spear", "spear_false")
		has_spear = false
	
	if has_spear:
		$spear_hand.show()
	else:
		$spear_hand.hide()
	
	look_at(get_global_mouse_position())
	move_and_slide(Vector2(x_dir, y_dir) * SPEED)

func take_spear():
	if has_spear:
		get_tree().call_group("spear", "spear_true")
	else:
		get_tree().call_group("spear", "spear_true")
		has_spear = true