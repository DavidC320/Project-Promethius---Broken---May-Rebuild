extends CharacterBody3D

var speed = 20
@export var direction = Vector3.ZERO
var visa = 5
var count = 0

var rush = true
var player_alive = true
var player_found = false

@onready var player = get_node("/root/Test/Player") as CharacterBody3D


func _physics_process(delta: float) -> void:
	if rush:
		movement(delta)


func search_player():
	var player_pos = player.global_transform.origin
	var saw_pos = global_transform.origin
	# Range
	# # - #     # | #
	# | # |     - + -
	# # - #     # | #
	
	# in Range
	var x_range = (saw_pos.x - visa) < player_pos.x and player_pos.x < (saw_pos.x + visa)
	var z_range = (saw_pos.z - visa) < player_pos.z and player_pos.z < (saw_pos.z + visa)
	if x_range or z_range:
		rush = false
		player_found = true
		if x_range:
			if saw_pos.z > player_pos.z:
				print('up')
				direction = Vector3(0, 0, -1)
			elif saw_pos.z < player_pos.z:
				print("down")
				direction = Vector3(0, 0, 1)
		elif z_range:
			if saw_pos.x < player_pos.x:
				print("right")
				direction = Vector3(1, 0, 0)
			elif saw_pos.x > player_pos.x:
				print("left")
				direction = Vector3(-1, 0, 0)
		get_node("Timers/wait").start()
		$Found.play()


func movement(delta):
	var velocity = direction.normalized() * speed
	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()


func _on_VisibilityNotifier_camera_exited(camera: Camera3D) -> void:
	queue_free()


func _on_Search_timeout() -> void:
	if player_alive and not player_found:
		search_player()


func _on_wait_timeout() -> void:
	rush = true
	speed = 200
	get_node("Timers/wait").stop()
	

func player_died():
	player_alive = false
