extends Control

var pre_game = preload("res://scenes/levels/initial_scene.tscn")
var game

func _ready():
	pass

# warning-ignore:unused_argument
func _process(delta):
	pass

func _on_jogar_pressed():
	$menu_content/select.play()
	$menu_content.hide()
	game = pre_game.instance()
	get_parent().add_child(game)

func _on_btn_sair_pressed():
	$menu_content/select.play()
	yield(get_tree().create_timer(0.3), "timeout")
	get_tree().quit()

func _on_btn_jogar_mouse_entered():
	$menu_content/change.play()

func _on_btn_opes_mouse_entered():
	$menu_content/change.play()

func _on_btn_sair_mouse_entered():
	$menu_content/change.play()