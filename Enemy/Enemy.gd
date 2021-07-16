extends Node2D

enum States { IDLE, FOLLOW }

const MASS = 10.0
const ARRIVE_DISTANCE = 10.0

export(float) var speed = 200.0
var _state = null

var _path = []
var _target_point_world = Vector2()
var _target_position = Vector2()

onready var timer = Timer.new()

var _velocity = Vector2()
var player = null

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	
	if tree.has_group("Player"):
		player = tree.current_scene.get_node("Player")
		player.connect("moved", self, "_on_Player_moved")
		_target_position = player.global_position

func _on_Player_moved():
	_get_path_to_player()
	_move_towards_player()
		
func _move_towards_player() -> void:
	var _arrived_to_next_point = _move_to(_target_point_world)
	if _arrived_to_next_point:
		_path.remove(0)
		if len(_path) == 0:
			print("HIT PLAYER")
			return
		_target_point_world = _path[0]

func _move_to(world_position):
	position = world_position
	return position.distance_to(world_position) < ARRIVE_DISTANCE


func _get_path_to_player():
	_target_position = player.global_position
	_path = get_parent().get_node("TileMap").get_astar_path(position, _target_position)
	if not _path or len(_path) == 1:
		return
	# The index 0 is the starting cell.
	# We don't want the character to move back to it in this example.
	_target_point_world = _path[1]
