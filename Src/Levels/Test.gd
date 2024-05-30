extends Node
# code by rayuse RP
# code by GDQuest

# Difficulty
@export var enemy_spawn_num = 1
@export var turret_spawn_num = 1
@export var saw_spawn_num = 1


@onready var player = $Player
var player_alive = true

var chas_s = preload("res://Src/Actor/Enemies/Chasers/Chaser.tscn")
var chas_d = preload("res://Src/Actor/Enemies/Chasers/Detonator.tscn")
var chas_r = preload("res://Src/Actor/Enemies/Chasers/Ranger.tscn")
var turret = preload("res://Src/Actor/Enemies/Turrets/Turret.tscn")

# code by Age of Asparagus
@onready var navmap = $Navigation/NavigationRegion3D
var random_map_cords := []

func enemy_spawner():
	# Slecects a random enemy and then places them within the spawn path
	# code by GDQuest
	var enemies = [chas_s, chas_d, chas_r]
	var enemy = enemies[randi() % enemies.size()].instantiate()
	
	var enemy_spawn_location = $Navigation/Spawn_path/PathFollow3D
	enemy_spawn_location.progress_ratio = randf()
	print(enemy_spawn_location.position)
	
	enemy.position = enemy_spawn_location.position
	$Navigation.add_child(enemy)
	
func turret_spawner():
	var enemy = turret.instantiate() as CharacterBody3D
	print(enemy)
	
	var scale_stuff = $Navigation/NavigationRegion3D/Field/MeshInstance3D.scale
	var x_range = [-scale_stuff.x, scale_stuff.x]
	var z_range = [-scale_stuff.z, scale_stuff.z]
	var pos = Vector3(randf_range(x_range[0], x_range[1]), 0 ,randf_range(z_range[0], z_range[1]))
	enemy.position = pos
	$Navigation.add_child(enemy)


func saw_spawner():
	var saw_spawners = get_node("Spawners").get_children()
	var selected = saw_spawners[randi() % saw_spawners.size()]
	selected.deploy_saw()


func _ready() -> void:
	randomize()
	$Player.connect("dodge", Callable($UI/Score, "_on_player_dodge"))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()


func _on_Spawner_timeout() -> void:
	for a in range(enemy_spawn_num):
		enemy_spawner()


func _on_Player_alive() -> void:
	# disables game
	player_alive = false
	$Music/p_death.play()
	get_tree().call_group("Enemy", "player_died")
	$Timers/Spawner.stop()
	$Timers/Saw_spawn.stop()
	$Timers/Turret_spawn.stop()



func _on_Turret_spawn_timeout() -> void:
	for a in range(turret_spawn_num):
		turret_spawner()


func _on_Saw_spawn_timeout() -> void:
	get_node("UI/Score")._player_survive()
	for a in range(saw_spawn_num):
		$SFX/Spawn_saw.play()
		saw_spawner()
