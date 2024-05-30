extends AudioStreamPlayer3D

func _ready():
	connect("finished", Callable(self, "die"))
	unit_size = 25
	play()
	
func die():
	queue_free()
