extends Node

var score = 0

@onready var score_label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = "Score: " + str(score)
#
#func _unhandled_input(event):
#	if event.is_action("shoot") and not event.is_echo():
#		if event.is():
#

#func _process(delta):
#	if Input.is_action_pressed("shoot"):
#		pass

var walking_enemy_scene = preload("res://scenes/WalkingTarget.tscn")

func _on_enemy_spawn_timer_timeout():
	var enemy = walking_enemy_scene.instantiate()
	enemy.position = Vector2(get_viewport().get_mouse_position())
	add_child(enemy)
	print("attempted to spawn enemy at position" + str(get_viewport().get_mouse_position()))
	