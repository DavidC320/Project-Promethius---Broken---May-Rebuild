extends CharacterBody3D

@onready var dead =  get_node("/root/Test/Music/Death") as AudioStreamPlayer3D  

func die():
	dead.play()
	queue_free()


func _on_death_timeout() -> void:
	die()


func _on_arm_timeout() -> void:
	$Timers/arm.stop()
	var turret = load("res://Src/Actor/Enemies/Turrets/Turret_Gun.tscn").instantiate()
	add_child(turret)


func _on_Bullethit_body_entered(body: Node) -> void:
	die()
