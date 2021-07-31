extends KinematicBody2D

const TILE_SIZE = 8
const coin = preload("res://coin/Coin.tscn")
const explosion = preload("res://Explosion.tscn")

var player = null
var is_moving = false
var chest_health = 3
var explosion_spawned = false

onready var ray = $RayCast2D
onready var anim_player = $AnimationPlayer
onready var audio = $AudioStreamPlayer2D

signal coin_awarded
signal blocked

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	
	if tree.has_group("Player"):
		player = tree.current_scene.get_node("Player")
		player.connect("bumped_chest", self, "_on_Player_bumped_chest")
		
func _physics_process(delta):
	pass


func _on_Player_bumped_chest(id,dir):
	if id == name:
		var desired_step: Vector2 = dir * TILE_SIZE / 2
	
		ray.cast_to = desired_step
		ray.force_raycast_update()
		
		if dir.x != 0:
			anim_player.play("move_horizontal")
		elif dir.y != 0:
			anim_player.play("move_vertical")
		
		if !ray.is_colliding():
			position += dir * TILE_SIZE # Move Chest if not colliding
			
			spawn_coin()
			
			audio.play()
		else:
			chest_health -= 1
			$ChestBumpSFX.play()
			if chest_health > 0:
				emit_signal("blocked")
			else:
				if not explosion_spawned:
					for x in 5:
						spawn_coin()
					create_explosion()
				
func destory_self():
	queue_free()
	
func spawn_coin():
	var coin_instance = coin.instance() # Create & Spawn Coin Instance
	add_child(coin_instance)
	coin_instance.position.x += 4
	emit_signal("coin_awarded") #let the game know the player has collected a coin
	
func create_explosion():
	var explosion_instance = explosion.instance() # Create & Spawn Coin Instance
	add_child(explosion_instance)
	explosion_instance.position.x += 4
	explosion_instance.connect("anim_complete", self, "destory_self")
	explosion_spawned = true
	$ChestDestroyedSFX.play()


func _on_Timer_timeout():
	spawn_coin()
