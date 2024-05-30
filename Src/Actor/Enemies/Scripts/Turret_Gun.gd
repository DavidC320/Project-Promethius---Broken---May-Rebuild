extends CharacterBody3D

@onready var target = get_node("/root/Test/Player") as CharacterBody3D
var player_alive = true

@export var angle_speed = 10


func rotationer(delta, rotation, velocity):
	# rotation
	var new_rotation = atan2(-velocity.x, -velocity.z)
	var exceleration = delta * angle_speed
	return lerp_angle(rotation, new_rotation, exceleration)
	

func movement(delta):
	$Node3D.rotation.y = rotationer(delta, $Node3D.global_rotation.y, -target)

func _physics_process(delta):
	if player_alive and target != null:
		#movement(delta)
		var aim = target.global_transform.origin
		aim.y = 0
		look_at(aim, Vector3.UP)


func fire():
	$AudioStreamPlayer3D.play()
	var scene = load("res://Src/Actor/Enemies/Hazards/Bullet.tscn")
	var bullet = scene.instantiate()
	bullet.position = $muzzle.global_transform.origin
	bullet.direction = target.global_transform.origin - $Node3D.global_transform.origin
	get_parent().get_parent().add_child(bullet)


func _on_Firerate_timeout():
	if player_alive and target != null:
		fire()
	
func player_died():
	player_alive = false
	$Firerate.stop()
