extends Chaser

var scene = load("res://Src/Actor/Enemies/Hazards/Bullet.tscn")
@onready var explode =  get_node("/root/Test/Music/explode") as AudioStreamPlayer3D

func _on_Death_timeout() -> void:
	play_sound("die")
	explode.play()
	die()


func die():
	queue_free()
	var bullets = [Vector3(1, 0, 0), Vector3(-1, 0, 0), Vector3(0, 0, 1), Vector3(0, 0, -1)]
	for vect in bullets:
		# code by Terrian
		var bullet = scene.instantiate()
		bullet.position = global_transform.origin
		bullet.direction = vect
		get_parent().add_child(bullet)


func _on_Bullethit_body_entered(body: Node) -> void:
	die()


func _on_Timer_timeout() -> void:
	current_node = 0
	update_path()
