extends KinematicBody2D

signal enemy_dead()

const DEATH_ZONE_ANGLE = .01
const ROT_VEL = 2

var alive = true
var bodys = []

func _ready():
	pass

func _process(delta):
	if bodys.size():
		var angle = get_angle_to(bodys[0].global_position)
		if abs(angle) > DEATH_ZONE_ANGLE:
			rotation += sign(angle) * delta * ROT_VEL
	pass
	
func autodestroy():
	alive = false
	get_tree().call_group("spawn", "dead_enemy")	
	queue_free()
	
func _on_sensor_body_entered(body):
	bodys.append(body)
	print(bodys.size())

func _on_sensor_body_exited(body):
	var index = bodys.find(body)
	if index >= 0:
		bodys.remove(index)