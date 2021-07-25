extends CanvasLayer

signal fade_out_complete

func _ready():
	pass
	
func fade_out():
	$AnimationPlayer.play("fade_out")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		emit_signal("fade_out_complete")
