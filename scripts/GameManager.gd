extends Node

func _ready():
	SignalBus.connect("headshot", _headshot)
	get_tree().paused = true

func _headshot():
	add_point()

var score = 0
@onready var score_label = $Labels/ScoreLabel
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

@onready var GameTimer = $GameTimer
func time_remaining():
	var time_left = GameTimer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

@onready var TimerLabel = $Labels/TimeRemaining
func _process(delta):
	TimerLabel.text = "%02d:%02d" % time_remaining()

var game_start = true;
var toggled = true;
func _on_button_pressed():
	if game_start:
		game_start = false;
		GameTimer.start()
	if toggled:
		toggled = false
		GameTimer.paused = false
		get_tree().paused = false
		$StartButton.text = "Pause"
	else:
		toggled = true
		GameTimer.paused = false
		get_tree().paused = true
		$StartButton.text = "Resume"

func _on_game_timer_timeout():
	pass # Replace with function body.
