extends Sprite
signal anim_complete

func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("anim_complete")
	queue_free()

