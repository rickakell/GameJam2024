extends Node

var score = 0

@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "Score: " + str(score)

var walking_enemy_scene = preload("res://scenes/WalkingTarget.tscn")

func _on_enemy_spawn_timer_timeout():
	var enemy = walking_enemy_scene.instantiate()
	enemy.position = Vector2(get_viewport().get_mouse_position())
	add_child(enemy)
	print("attempted to spawn enemy at position" + str(get_viewport().get_mouse_position()))

func _ready():
	SignalBus.connect("headshot", _headshot)

func _headshot():
	add_point()
