extends CharacterBody3D

var camera = Camera3D
@export var angle_speed = 20
@export var ray_length = 1000

func rotationer(delta, rotation, velocity):
	# rotation
	var inital_y_rotation = rotation
	var new_rotation = atan2(velocity.x, velocity.z)
	var exceleration = delta * angle_speed
	return lerp_angle(inital_y_rotation, new_rotation, exceleration)

func camera_pos_to_vector3() -> Vector3:
	# Rotation by ?
	var player_pos = global_transform.origin
	var dropPlane = Plane(Vector3(0, 1, 0), player_pos.y) # This is an invisable
	#plane for Ray casting
	var mouse_pos = get_viewport().get_mouse_position()
	var from_camera = camera.project_ray_origin(mouse_pos)
	var to_camera = from_camera + camera.project_ray_normal(mouse_pos) * ray_length
	var cursor_pos = dropPlane.intersects_ray(from_camera, to_camera)
	
	return cursor_pos

func _physics_process(delta: float) -> void:
	var cursor_pos = -camera_pos_to_vector3()
	#$Spatial.rotation.y = rotationer(delta, $Spatial.global_rotation.y, cursor_pos)  # takes two vector 3s
	$Node3D.look_at(cursor_pos, Vector3.UP)
