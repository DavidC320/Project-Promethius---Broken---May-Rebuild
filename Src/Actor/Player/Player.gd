extends CharacterBody3D
# code based off of GDQuest 3D tutorial

# signals
signal alive
signal dodge

@export var speed = 40.0
var _velocity = Vector3.ZERO

func controller(velocity: Vector3, speed: float) -> Vector3:
	var direction = Vector3.ZERO
	# Movement
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
		
	# Normalizes the palyer's movemnt making diagonal movment the same as
	# horizontal and vertical movement
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	# applies changes
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y = 0
	return velocity

func _physics_process(delta: float) -> void:
	_velocity = controller(_velocity, speed)
	set_velocity(_velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	_velocity = velocity
	
	
func die():
	queue_free()
	emit_signal("alive")

func _on_HitBox_body_entered(body: Node) -> void:
	die()


func _on_DodgeBox_body_exited(body: Node) -> void:
	emit_signal("dodge")
