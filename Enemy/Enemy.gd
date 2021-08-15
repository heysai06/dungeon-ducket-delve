extends KinematicBody2D

const TILE_SIZE = 8

export var  walk_speed = 4

var initial_position = Vector2(0,0)
var input_direction = Vector2(0,0)
var is_moving = false
var percent_moved_to_next_tile = 0.0

var _path = []
var _target_point_world = Vector2()
var _target_position = Vector2()

onready var timer = Timer.new()
onready var ray = $RayCast2D
onready var anim_player = $AnimationPlayer

var player = null

signal hit_player(dir)

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	anim_player.play ("Idle")
	
	if tree.has_group("Player"):
		player = tree.current_scene.get_node("Player")
		player.connect("turn_over", self, "_on_Player_moved")
		player.connect("hit_enemy", self, "_on_player_hit_me")
		_target_position = player.global_position
	
	initial_position = position

func _physics_process(delta):
	if is_moving:
		var desired_step: Vector2 = input_direction * TILE_SIZE / 2
	
		ray.cast_to = desired_step
		ray.force_raycast_update()
		
		if !ray.is_colliding(): # Check for collision before moving
			percent_moved_to_next_tile += walk_speed * delta
			if percent_moved_to_next_tile >= 1.0:
				position = initial_position + (TILE_SIZE * input_direction)
				percent_moved_to_next_tile = 0.0
				is_moving = false
				
				_path.remove(0)
				if len(_path) == 0:
					print("HIT PLAYER")
					return
				#_target_point_world = _path[0]
			else:
				position = initial_position + (TILE_SIZE * input_direction * percent_moved_to_next_tile)
		else:
			if ray.get_collider().is_in_group("Player"):
				emit_signal("hit_player", input_direction)
				is_moving = false

func _on_Player_moved():
	initial_position = position

	_get_path_to_player()

	input_direction.x = (int(_target_point_world.x) - int(position.x))
	input_direction.y = (int(_target_point_world.y) - int(position.y))
	input_direction = input_direction.normalized()
	
	is_moving = true

# Find the path to the player
func _get_path_to_player():
	_target_position = player.global_position
	_path = get_parent().get_node("TileMap").get_astar_path(position, _target_position)
	if not _path or len(_path) == 1:
		return
	# The index 0 is the starting cell.
	# We don't want the character to move back to it in this example.
	_target_point_world = _path[1] - Vector2(4,4)

# What happens when the player hits this enemy
func _on_player_hit_me(id,dir):
	if id == name:
		print("PLAYER HIT ENEMY")
		var desired_step: Vector2 = dir * TILE_SIZE / 2
	
		ray.cast_to = desired_step
		ray.force_raycast_update()
		
		if !ray.is_colliding():
			position += dir * TILE_SIZE
	pass
