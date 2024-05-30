extends Chaser

func _on_Death_timeout() -> void:
	die()


func die() -> void:
	play_sound("die")
	queue_free()


func _on_Bullethit_body_entered(body: Node) -> void:
	die()


func _on_Timer_timeout() -> void:
	current_node = 0
	update_path()
