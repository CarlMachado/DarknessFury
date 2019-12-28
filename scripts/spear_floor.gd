extends Area2D

func _ready():
	pass

func _on_spear_body_entered(body):
	print("pegou")
	get_tree().call_group("player", "take_spear")
	queue_free()