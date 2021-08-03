extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.level_list.size()-1 > Global.current_level:
		Global.current_level += 1


func _on_Timer_timeout():
	Global.goto_scene(Global.level_list[Global.current_level])
