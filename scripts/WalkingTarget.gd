extends CharacterBody2D

var speed = 10000

var direction = 1

func move_down(delta):
	velocity.y = speed * delta

func move(delta):
	velocity.x = speed * delta * direction

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var head = $CollisionShapeHead

func _physics_process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	if !is_on_floor():
		move_down(delta)
	move(delta)
	move_and_slide()


func _on_collision_shape_head_input_event(viewport, event, shape_idx):
	if event.is_action("shoot"):
		SignalBus.emit_signal("headshot")
		queue_free()
