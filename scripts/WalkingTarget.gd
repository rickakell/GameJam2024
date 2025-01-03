extends CharacterBody2D

var speed = 10000 : set = speed_set_state

func speed_set_state(value):
	speed = value

var direction = 1 : set = direction_set_state

func direction_set_state(value):
	direction = value
	set_flip_state(direction)

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
		set_flip_state(direction)
	if ray_cast_left.is_colliding():
		direction = 1
		set_flip_state(direction)
	if !is_on_floor():
		move_down(delta)
	move(delta)
	move_and_slide()

var can_shoot = true
func _on_collision_shape_head_input_event(_viewport, event, _shape_idx):
	if event.is_action("shoot") and can_shoot:
		can_shoot = false
		get_tree().create_timer(.5).timeout.connect(func(): can_shoot = true)
		SignalBus.emit_signal("headshot")
		queue_free()

func set_flip_state(current_direction):
	if current_direction == 1:
		animated_sprite.flip_h = false
	if current_direction == -1:
		animated_sprite.flip_h = true
