extends ColorRect

enum {ESQUERDA, DIREITA}

onready var active_skill_bar = false
onready var init_position = rect_global_position

export var speed = 275

var size = DIREITA # 0 esquerda / 1 direita

var start = false

func _ready():
	pass 

func _process(delta):
	if active_skill_bar:
		if !start:
			size = randi() % 2
			if size == DIREITA:
				rect_global_position.x = 542
			else:
				rect_global_position.x = 721
			start = true
#		print("x: " + str(rect_global_position.x))
		if rect_global_position.x - speed * delta > 542 and size == 0:	
			rect_global_position.x -= speed * delta
		else:
			size = DIREITA
			
		if rect_global_position.x + speed * delta < 725 and size == 1:
			rect_global_position.x += speed * delta
		else:
			size = ESQUERDA
	else:
		start = false

func action():
	if rect_global_position.x + rect_size.x > 604 and rect_global_position.x + rect_size.x < 664:  # area verde
		get_tree().call_group("player", "skill_action", 1)
	else: # area vermelha
		get_tree().call_group("player", "skill_action", 0)
		
func active():
	rect_global_position = init_position
	active_skill_bar = true
	
func desactive():
	active_skill_bar = false