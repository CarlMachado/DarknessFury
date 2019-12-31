extends ColorRect

onready var active_skill_bar = false

onready var init_position = rect_global_position
var speed = 50
var size = 0 # 0 esquerda / 1 direita

func _ready():
	pass 

func _process(delta):
	if active_skill_bar:
		print("x: " + str(rect_global_position.x))
		if rect_global_position.x - speed * delta > 542 and size == 0: # cheguei no verde -> rect_global_position.x > 632
			rect_global_position.x -= speed * delta
		else:
			size = 1
			
		if rect_global_position.x + speed * delta < 725 and size == 1:
			rect_global_position.x += speed * delta
		else:
			size = 0

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