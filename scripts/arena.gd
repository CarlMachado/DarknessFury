extends Node2D

var boss = false

# controles
var frames = 0
var stage = 0
var init_dialog = false
var dialog = 0

# warning-ignore:unused_argument
func _process(delta):
	if not $intimidation.playing:
		$intimidation.play()
	
	if boss:
		frames += 1
		if stage == 0:
			$anim_boss/arena_entrance/block_floor.show()
			$anim_boss/arena_entrance/block_floor2.show()
			$anim_boss/arena_entrance/castle.show()
			$anim_boss/arena_entrance/castle2.show()
			$anim_boss/doors/left_door_midle.show()
			$anim_boss/doors/right_door_midle.show()
			if frames > 60:
				frames = 0
				stage += 1
		
		if stage == 1:
			$anim_boss/doors/left_door_open.show()
			$anim_boss/doors/right_door_open.show()
			if frames > 60:
				frames = 0
				stage += 1
		
		if stage == 2:
			$anim_boss/boss/anim_sprite.play("walk")
			$anim_boss/boss.translate(Vector2(0, 1))
			if frames > 130:
				$anim_boss/boss/anim_sprite.play("idle")
				frames = 0
				stage += 1
		
		if stage == 3:
			$anim_boss/doors/left_door_open.hide()
			$anim_boss/doors/right_door_open.hide()
			if frames > 60:
				frames = 0
				stage += 1
		
		if stage == 4:
			$anim_boss/doors/left_door_midle.hide()
			$anim_boss/doors/right_door_midle.hide()
			$anim_boss/arena_entrance/block_floor.hide()
			$anim_boss/arena_entrance/block_floor2.hide()
			$anim_boss/arena_entrance/castle.hide()
			$anim_boss/arena_entrance/castle2.hide()
			if frames > 60:
				frames = 0
				stage += 1
		
		if stage == 5:
			if not init_dialog:
				$anim_boss/dialogues/speak_ballon_1.show()
				init_dialog = true
			if Input.is_action_just_pressed("ui_accept") and dialog == 0:
				$next.play()
				$anim_boss/dialogues/speak_ballon_1.hide()
				$anim_boss/dialogues/speak_ballon_2.show()
				dialog += 1
			elif Input.is_action_just_pressed("ui_accept") and dialog == 1:
				$next.play()
				$anim_boss/dialogues/speak_ballon_2.hide()
				$anim_boss/dialogues/speak_ballon_3.show()
				dialog += 1
			elif Input.is_action_just_pressed("ui_accept") and dialog == 2:
				$next.play()
				$anim_boss/dialogues/speak_ballon_3.hide()
				$anim_boss/dialogues/speak_ballon_4.show()
				dialog += 1
			elif Input.is_action_just_pressed("ui_accept") and dialog == 3:
				$next.play()
				$anim_boss/dialogues/speak_ballon_4.hide()
				$anim_boss/dialogues/speak_ballon_5.show()
				dialog += 1
			elif Input.is_action_just_pressed("ui_accept") and dialog == 4:
				$next.play()
				$anim_boss/dialogues/speak_ballon_5.hide()
				$anim_boss/dialogues/speak_ballon_6.show()
				dialog += 1
			elif Input.is_action_just_pressed("ui_accept") and dialog == 5:
				$next.play()
				$anim_boss/dialogues/speak_ballon_6.hide()
				$anim_boss/dialogues/speak_ballon_7.show()
				dialog += 1
			elif Input.is_action_just_pressed("ui_accept") and dialog == 6:
				$next.play()
				$anim_boss/dialogues/speak_ballon_7.hide()
				$anim_boss/dialogues/speak_ballon_8.show()
				dialog += 1
			elif Input.is_action_just_pressed("ui_accept") and dialog == 7:
				$next.play()
				$anim_boss/dialogues/speak_ballon_8.hide()
				$anim_boss/dialogues/speak_ballon_9.show()
				dialog += 1
			elif Input.is_action_just_pressed("ui_accept") and dialog == 8:
				$next.play()
				$anim_boss/dialogues/speak_ballon_9.hide()
				boss = false
				stage = -1
				get_tree().call_group("player", "set_status_playing")

func init_boss():
	boss = true