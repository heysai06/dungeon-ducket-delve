extends Node2D


func _ready():
	$AnimationPlayer.play("move_up")


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
	pass # Replace with function body.
