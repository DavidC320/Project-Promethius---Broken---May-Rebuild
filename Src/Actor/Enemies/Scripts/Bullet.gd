extends CharacterBody3D
class_name  bullet

var speed = 40
var _velocity = Vector3.ZERO
@export var direction = Vector3.ZERO
# bullet rotation from Johnny Rouddro
@export var angle_speeed = 10

func _ready() -> void:
	global_transform.origin.y += .2

func _physics_process(delta):
	movement(delta)
	
func rotationer(delta, rotation, velocity):
	# rotation
	var inital_y_rotation = rotation
	var new_rotation = atan2(-velocity.x, -velocity.z)
	var exceleration = delta * angle_speeed
	return lerp(inital_y_rotation, new_rotation, exceleration)
	

func movement(delta):
	_velocity = direction.normalized() * speed
	set_velocity(_velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	
	$Node3D.rotation.y = rotationer(delta, $Node3D.rotation.y, _velocity)
	

func _on_Area_body_entered(body: Node) -> void:
	if not $Area3D/CollisionShape3D.disabled:
		queue_free()
		print(body.name)


func _on_enable_col_timeout() -> void:
	$Area3D/CollisionShape3D.disabled = false
