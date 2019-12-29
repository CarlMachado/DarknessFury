extends KinematicBody2D

signal enemy_dead()

const DEATH_ZONE_ANGLE = .01
const ROT_VEL = 2

var homming = false
var alive = true
#var bodys = []
var vel = 50
var body 

func _ready():
	yield(get_tree().create_timer(60), "timeout")
	homming = true

func _physics_process(delta):
	if !homming:
		move_and_slide(Vector2(cos(rotation), sin(rotation)) * 50)
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