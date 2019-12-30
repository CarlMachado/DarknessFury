extends StaticBody2D

const PRE_SPEAR_FLOOR = preload("res://prefabs/spear_floor.tscn")
const MAX_SPEED = 400
const MIN_SPEED = 0
const DEATH_ZONE_ACELL = 30
const DEATH_ZONE_ANGLE = .01

var dir = Vector2()
var vel_init = 1500
var max_dist = 650
var homming = false
var acell = vel_init

onready var target
onready var target_position
onready var initpos = self.global_position	

func _ready():
	if target != null:
		target_position = target.global_position

func _physics_process(delta):
	acell = lerp(acell, MIN_SPEED, .035) 
	translate(dir * acell * delta)
	#if global_position.distance_to(initpos) > max_dist:
	if acell <= DEATH_ZONE_ACELL or goalTarget():
		acell = lerp(acell, MIN_SPEED, rand_range(0.2, 0.4))
	if acell <= .1:
		stop_projectile()

func goalTarget():
	if target != null:
		return global_position.distance_to(target_position) <= rand_range(10, 30)
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