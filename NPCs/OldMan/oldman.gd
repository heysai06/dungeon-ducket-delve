extends Node

onready var anim_player = $AnimationPlayer
var player
const dialogue_box = preload("res://Narrative/TextBox.tscn") 

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play ("Idle")
	
	yield(get_tree(), "idle_frame")
	var tree = get_tree()
	
	if tree.has_group("Player"):
		player = tree.current_scene.get_node("Player")
		player.connect("bumped_npc", self, "trigger_dialogue")

func trigger_dialogue():
	var dialog = dialogue_box.instance() # Create & Spawn Coin Instance
	player.add_child(dialog)
	dialog.position -= Vector2(80,40)

