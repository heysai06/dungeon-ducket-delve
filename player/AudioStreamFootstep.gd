extends AudioStreamPlayer


func _ready():
	get_node("..").connect("moved", self, "_on_player_moved")

func _on_player_moved():
	self.pitch_scale = rand_range(0.9, 1.1)
	self.play()
