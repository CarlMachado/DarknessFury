extends Control

var pre_game = preload("res://scenes/levels/arena.tscn")
var game

func _ready():
	pass

func _on_jogar_pressed():
	$menu_content.hide()
	game = pre_game.instance()
	add_child(game)


func _on_btn_sair_pressed():
	get_tree().quit()
