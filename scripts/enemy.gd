extends KinematicBody2D

const PRE_SPEAR = preload("res://prefabs/spear_hand.tscn")
const DEATH_ZONE_ANGLE = .01
const ROT_VEL = 1

var homming = false
var alive = true

var loaded = true
#var bodys = []
var vel = rand_range(40, 60)
var body 

func _ready():
	yield(get_tree().create_timer(60), "timeout")
	homming = true

func _physics_process(delta):
	if !homming:
		move_and_slide(Vector2(cos(rotation), sin(rotation)) * vel)
	else:
		if loaded and body != null:
			var correct	
			if global_position.distance_to(body.global_position) > 300:
				correct = 0.05
			elif global_position.distance_to(body.global_position) > 600:
				correct = 0.020
			else:
				correct = 0.175
			var spear_attack = PRE_SPEAR.instance()
			spear_attack.global_position = $spear.global_position
			spear_attack.rotation = global_rotation
			spear_attack.dir = Vector2(cos(rotation + correct), sin(rotation + correct))
			spear_attack.target = body
			get_parent().add_child(spear_attack)
			$spear.hide()
			loaded = false
			$reload.start()
	if body != null:
		var angle = get_angle_to(body.global_position)
		if abs(angle) > DEATH_ZONE_ANGLE:
			rotation += sign(angle) * delta * ROT_VEL
	
func autodestroy():
	alive = false
	get_tree().call_group("spawn", "dead_enemy")	
	queue_free()

func stop_in_area():
	homming = true
	
func _on_sensor_body_entered(body):
	self.body = body
	$sensor.queue_free()
	#bodys.append(body)

#func _on_sensor_body_exited(body):
#	var index = bodys.find(body)
#	if index >= 0:
#		bodys.remove(index)

func _on_reload_timeout():
	loaded = true
	$spear.show()
	$reload.stop()
