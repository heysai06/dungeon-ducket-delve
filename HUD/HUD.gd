extends Control

var player

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	
	if tree.has_group("Player"):
		player = tree.current_scene.get_node("Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RichTextLabel.text = String(player.coins_collected) + " / 5"
