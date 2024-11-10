extends Node

func _ready():
	SignalBus.connect("headshot", _headshot)

func _headshot():
	add_point()

var score = 0
@onready var score_label = $ScoreLabel
func add_point():
	score += 1
	score_label.text = "Score: " + str(score)

var walking_enemy_scene = preload("res://scenes/WalkingTarget.tscn")
@export var mob_scene: PackedScene
func _on_enemy_spawn_timer_timeout():
	var enemy = walking_enemy_scene.instantiate()
	var spawn_location = $EnemyPaths/EnemyPath/SpawnPath
	spawn_location.progress_ratio = randf()
	enemy.position = spawn_location.position
	enemy.speed = randf_range(8000, 12000)
	add_child(enemy)

func _on_enemy_spawn_timer_2_timeout():
	var enemy = walking_enemy_scene.instantiate()
	var spawn_location2 = $EnemyPaths/EnemyPath2/SpawnPath2
	spawn_location2.progress_ratio = randf()
	enemy.position = spawn_location2.position
	enemy.speed = randf_range(10000, 13000)
	enemy.set_collision_mask_value(2, true)
	add_child(enemy)

func _on_enemy_spawn_timer_3_timeout():
	var enemy = walking_enemy_scene.instantiate()
	var spawn_location3 = $EnemyPaths/EnemyPath3/SpawnPath3
	spawn_location3.progress_ratio = randf()
	enemy.position = spawn_location3.position
	enemy.speed = randf_range(13000, 15000)
	enemy.set_collision_mask_value(3, true)
	%Tiles/TileMap3.add_child(enemy)

func _input(event):
	if event.is_action("shoot"):
		$AudioStreamPlayer2D.play()
