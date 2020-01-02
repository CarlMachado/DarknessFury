extends Node

signal kills_changed 
signal reload 
signal unload 
signal restart 

var kills = 0 setget set_kills

func _ready():
	pass 

func add_kill():
	kills += 1
	emit_signal("kills_changed")

func set_kills(val):
	print("Can't Write Kill. Use funtion add_kill")

func reload(loaded, has_spear):
	emit_signal("reload", loaded, has_spear)
	
func unload():
	emit_signal("unload")
	
func restart():
	emit_signal("restart")



