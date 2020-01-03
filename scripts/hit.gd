extends Area2D

signal hitted()
signal destroid()

export var health = 30

func hit(damage):
	health -= damage
	emit_signal("hitted")
	if health <= 0:
		emit_signal("destroid")