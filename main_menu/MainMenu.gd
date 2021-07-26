extends Node2D

var transition_layer
func _ready():
	yield(get_tree(), "idle_frame")
	var tree = get_tree()

	transition_layer = tree.current_scene.get_node("TransitionLayer")
	transition_layer.connect("fade_out_complete", self, "switch_scenes")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_ENTER):
		transition_layer.fade_out()
#	pass

func switch_scenes():
#	get_tree().change_scene("res://Levels/TutorialLevel.tscn")
	Global.goto_scene("res://Levels/TutorialLevel.tscn")
	
