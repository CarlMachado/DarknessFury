extends Node

signal kills_changed 
signal reload 
signal unload 
signal restart 
signal win 
signal generation_new_spawn

const KILLS_INCREMENT = 5
const KILLS_STOP_SPAWN = 10

var enemys_spawn
var kills = 0 setget set_kills
var kills_accumulated = 0
var player_live

var boss_dialogue
var win

func _ready():
	randomize()
	enemys_spawn = 0
	win = false
	player_live = true
	boss_dialogue = true

func add_kill():
	kills += 1
	kills_accumulated += 1
	if kills_accumulated >= KILLS_INCREMENT:
		kills_accumulated = 0
		new_spawn()
	emit_signal("kills_changed")

func set_kills(val):
	val = 0
	print("Can't Write Kill. Use funtion add_kill")

func reload(loaded, has_spear):
	emit_signal("reload", loaded, has_spear)
	
func unload():
	emit_signal("unload")
	
func restart():
	emit_signal("restart")

func new_spawn():
	emit_signal("generation_new_spawn")
	
func win():
	emit_signal("win")
	win = true
	
	
	
	
	
	
	