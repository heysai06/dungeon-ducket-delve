extends Node2D

const coin = preload("res://coin/Coin.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.increase_coin_collected_count()
		spawn_coin()
		queue_free()

func spawn_coin():
	var coin_instance = coin.instance() # Create & Spawn Coin Instance
	add_child(coin_instance)
	coin_instance.position.x += 4
	emit_signal("coin_awarded") #let the game know the player has collected a coin
