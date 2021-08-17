extends Control

var player
var level

func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	
	if tree.has_group("Player"):
		player = tree.current_scene.get_node("Player")
		
	level = tree.current_scene.get_node("TileMap")
	print(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RichTextLabel.text = String(player.coins_collected) + "/" + String(level.coin_goal)
	$RichTextLabel2.bbcode_text = "[right]LVL " + String(Global.current_level+1) + "[/right]"; 
