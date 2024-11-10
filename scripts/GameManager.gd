extends Node

@export var mob_scene: PackedScene

var score = 0

@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "Score: " + str(score)

var walking_enemy_scene = preload("res://scenes/WalkingTarget.tscn")

func _on_enemy_spawn_timer_timeout():
	var enemy = walking_enemy_scene.instantiate()
	var spawn_location = $EnemyPath/SpawnPath
	spawn_location.progress_ratio = randf()
	enemy.position = spawn_location.position
	enemy.speed = randf_range(8000, 12000)
	add_child(enemy)
	print("attempted to spawn enemy at position" + str(enemy.position))

func _ready():
	SignalBus.connect("headshot", _headshot)

func _headshot():
	add_point()
