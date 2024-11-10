extends CharacterBody2D
var speed = 10000

func move_up(delta):
	velocity.y = -speed * delta

func move_down(delta):
	velocity.y = speed * delta

func move_left(delta):
	velocity.x = -speed * delta

func move_right(delta):
	velocity.x = speed * delta

func _physics_process(delta):
	if !is_on_floor():
		move_down(delta)
	move_right(delta)
	move_and_slide()
