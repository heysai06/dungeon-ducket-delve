extends Node


# Declare member variables here. Examples:
var isMuted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("mute"):
		if isMuted:
			# umute
			AudioServer.set_bus_mute(0,false)
		else:
			# mute
			AudioServer.set_bus_mute(0,true)
		isMuted = !isMuted
