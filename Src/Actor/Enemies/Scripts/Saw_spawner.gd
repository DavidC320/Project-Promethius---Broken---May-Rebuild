extends Node3D

@export var go_up = false
@export var go_down = false
@export var go_left = false
@export var go_right = false


func get_dir_list():
	var directions = []
	if go_up:
		directions.append(Vector3(0, 0, -1))
	if go_down:
		directions.append(Vector3(0, 0, 1))
	if go_left:
		directions.append(Vector3(-1, 0, 0))
	if go_right:
		directions.append(Vector3(1, 0, 0))
	return directions


func deploy_saw() -> void:
	var operate = go_up or go_down or go_left or go_right
	if operate:
		var directions = get_dir_list()
		var direction = directions[randi() % directions.size()]
		var saw = load("res://Src/Actor/Enemies/Hazards/Saw.tscn").instantiate()
		
		saw.position = global_transform.origin
		saw.direction = direction
		get_node("/root/Test/Navigation").add_child(saw)
		
 
