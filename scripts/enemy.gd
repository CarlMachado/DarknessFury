extends KinematicBody2D

const DEATH_ZONE_ANGLE = .01
const ROT_VEL = 200

var alive = true
var bodys = []

func _ready():
	pass

func _process(delta):
	if bodys.size():
		var angle = self.get_angle_to(bodys[0].global_position)
		if abs(angle) > DEATH_ZONE_ANGLE:
			self.rotation += sign(angle) * delta * ROT_VEL
	pass
	
func _on_sensor_body_entered(body):
	print("entrei")
	bodys.append(body)

func _on_sensor_body_exited(body):
	var index = bodys.find(body)
	if index >= 0:
		bodys.remove(index)
