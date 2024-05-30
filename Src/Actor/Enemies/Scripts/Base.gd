extends CharacterBody3D
# code by Terian
# path finding by Rayuse rp
# better Vaving by Age of Asparagus
class_name Chaser

# Readys
#Age readys
# getting the nodes with the help of GlaDOSik
@onready var nav = get_node("/root/Test/Navigation") as Navigation
@onready var player = get_node("/root/Test/Player") as CharacterBody3D
# The as in these vars tell godot what kind of node we are expecting to get
# This helps with the auto complete

# exports
@export var speed = 10

# vars
var player_alive = true

# Pathfinding
var current_node = 0
var path = []
var threshold = 1

# sfx
@onready var dead = get_node("/root/Test/Music/Death")

func play_sound(act):
	var scene = load("res://Src/Actor/Audio/Audio_destroy.tscn")
	var sound = scene.instantiate()
	var aud = load("res://Art/sfx/337845__newagesoup__small-metal-hit-05.wav")
	if act == "die":
		aud = load("res://Art/sfx/337845__newagesoup__small-metal-hit-05.wav")
	else:
		aud = load("res://Art/sfx/347168__davidsraba__explosion-sound.wav")
		
	sound.stream = aud
	
	get_node("/root/Test/SFX").add_child(sound)


func _ready() -> void:
	move_to_target()

	
func _physics_process(_delta):
	if player_alive and player != null:
		move_to_target()

func move_to_target():
	if path.size() > current_node:
		var direction: Vector3 = path[current_node] - global_transform.origin
		if direction.length() < .5:
			current_node += 1
		else:
			# Declaring something after a : will help auto complete
			var velocity = direction.normalized() * speed
			set_velocity(velocity)
			set_up_direction(Vector3.UP)
			move_and_slide()


func update_path():
	if player_alive and player != null:
		var pos = global_transform.origin
		var tar_pos = player.global_transform.origin
		path = nav.get_simple_path(pos, tar_pos)
	
func player_died():
	player_alive = false
	

