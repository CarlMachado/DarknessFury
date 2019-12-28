extends Node2D

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(delta):
	$sprite.position = get_global_mouse_position() / 2