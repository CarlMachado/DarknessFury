extends Control

var tutorial = false
var pre_game = preload("res://scenes/levels/initial_scene.tscn")
var pre_restart = preload("res://scenes/levels/arena.tscn")

var game

func _ready():
	pass

# warning-ignore:unused_argument
func _process(delta):
	if tutorial:
		$menu_content/tutorial_content.show()
		$menu_content/change.stop()
		$menu_content/select.stop()
	else:
		$menu_content/tutorial_content.hide()
	
	if Input.is_action_just_pressed("ui_cancel") and tutorial:
		tutorial = false

func _on_jogar_pressed():
	if !tutorial:
		if game != null:
			game.queue_free()
			game = pre_restart.instance()
		else:
			$menu_content/select.play()
			$menu_content.hide()
			game = pre_game.instance()
		get_parent().add_child(game)

func _on_btn_opes_pressed():
	tutorial = true

func _on_btn_sair_pressed():
	if !tutorial:
		$menu_content/select.play()
		yield(get_tree().create_timer(0.3), "timeout")
		get_tree().quit()

func _on_btn_jogar_mouse_entered():
	if !tutorial:
		$menu_content/change.play()

func _on_btn_opes_mouse_entered():
	if !tutorial:
		$menu_content/change.play()

func _on_btn_sair_mouse_entered():
	if !tutorial:
		$menu_content/change.play()