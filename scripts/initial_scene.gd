extends Node2D

var anim = true
var cur_frame = 0
var stage = -1

func _ready():
	pass

func initial_animation():
	cur_frame += 1
	
	if cur_frame > 40 and $content/player_down.frame < 3:
		$content/player_down.frame += 1
		cur_frame = 0
	
	elif stage == -1 and cur_frame > 40 and $content/player_down.frame == 3:
		$content/player_down.hide()
		$content/player.show()
		stage = 0
		cur_frame = 0
	
	if stage == 0 and cur_frame > 50:
		$content/interrogation.show()
		stage += 1
		cur_frame = 0
	
	if stage == 1 and cur_frame > 50:
		$content/player.flip_h = true
		stage += 1
		cur_frame = 0
	
	if stage == 2 and cur_frame > 50:
		$content/player.flip_h = false
		stage += 1
		cur_frame = 0
	
	if stage == 3 and cur_frame > 50:
		$content/interrogation.hide()
		stage += 1
		cur_frame = 0

func dialogue_animation():
	if stage == 4 and cur_frame > 60:
		$content/initial_dialogues/speak_ballon_1.show()
		stage = 666
	
	if Input.is_action_just_pressed("ui_accept") and $content/initial_dialogues/speak_ballon_1.is_visible_in_tree():
		$next.play()
		$content/initial_dialogues/speak_ballon_1.hide()
		$content/initial_dialogues/speak_ballon_2.show()
	elif Input.is_action_just_pressed("ui_accept") and $content/initial_dialogues/speak_ballon_2.is_visible_in_tree():
		$next.play()
		$content/initial_dialogues/speak_ballon_2.hide()
		$content/initial_dialogues/speak_ballon_3.show()
	elif Input.is_action_just_pressed("ui_accept") and $content/initial_dialogues/speak_ballon_3.is_visible_in_tree():
		$next.play()
		anim = false
		scale = scale / 2
		$content.queue_free()
		add_child(preload("res://scenes/levels/arena.tscn").instance())

func _process(delta):
	if(anim):
		if not $celebration.playing:
			$celebration.play()
		initial_animation()
		dialogue_animation()