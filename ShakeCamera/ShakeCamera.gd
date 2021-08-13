extends Camera2D
class_name ShakeCamera

var shake = 0.0
var shake_power = 2
export var decay = 0.8
export var max_offset = Vector2(8, 4)
export var max_roll = 0.1
export (NodePath) var target


func _ready():
	randomize()
	
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for x in enemies:
		x.connect("hit_player", self, "add_shake")
	
	$"../Player".connect("hit_enemy", self, "add_shake")

func _process(delta):
	if Input.is_key_pressed(KEY_9):
		add_shake()
		
	if target:
		global_position = get_node(target).global_position
		
	if shake:
		shake = max(shake - decay * delta, 0)
		_shake()
	else:
		rotation = 0
		offset.x = 0
		offset.y = 0

func _shake():
	var amount = pow(shake, shake_power)
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)

func add_shake(amount: float = 0.5):
	shake = min(shake + amount, 1.0)
