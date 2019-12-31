extends Area2D

const PRE_SPEAR_FLOOR = preload("res://prefabs/spear_floor.tscn")
const MIN_SPEED = 800
const DEATH_ZONE_ACELL = 30
const DEATH_ZONE_ANGLE = .01

var dir = Vector2()
var vel_init = 1000
var acell = vel_init
var damage = 10
var type = ""

onready var target
onready var target_position
onready var initpos = self.global_position	

func _ready():
	if target != null:
		target_position = target.global_position

func _physics_process(delta):
	acell = lerp(acell, MIN_SPEED, .05) 
	translate(dir * acell * delta)
	#if global_position.distance_to(initpos) > max_dist:
	if acell <= DEATH_ZONE_ACELL or goalTarget():
		stop_projectile()

func goalTarget():
	if target != null:
		return global_position.distance_to(target_position) <= rand_range(10, 67)
	else:
		return false

func autodestroy():
	queue_free()
	
func stop_projectile():
	var spear_floor = PRE_SPEAR_FLOOR.instance()
	spear_floor.global_position = global_position
	spear_floor.rotation = global_rotation
	get_parent().add_child(spear_floor)
	autodestroy()

func auto_destroy():
	queue_free()

func _on_spear_hand_area_entered(area):
	var area_layer = area.get_collision_layer()
	if (area_layer == 32 and type == "enemy_attack") or (area_layer == 16 and type == "player_attack"):
		if area.has_method("hit"):
			area.hit(damage, self) 
			auto_destroy()
