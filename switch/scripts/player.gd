extends CharacterBody2D

# Movement variables
var speed: float = 600
var acceleration: float = 1600
var deceleration: float = 1600
var target_velocity: Vector2 = Vector2.ZERO
var moving_left: bool = false

func _ready() -> void:
	print("Player is ready!")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				toggle_direction()

func toggle_direction() -> void:
	moving_left = !moving_left
	print("Direction toggled: ", moving_left)

func _process(delta: float) -> void:
	if moving_left:
		target_velocity.x = -speed
	else:
		target_velocity.x = speed

	if velocity.x != target_velocity.x:
		if target_velocity.x > velocity.x:
			velocity.x += acceleration * delta
		elif target_velocity.x < velocity.x:
			velocity.x -= deceleration * delta

		velocity.x = clamp(velocity.x, -speed, speed)
	else:
		if velocity.x != 0:
			velocity.x = move_toward(velocity.x, 0, deceleration * delta)

	move_and_slide()

func move_toward(current: float, target: float, delta: float) -> float:
	if current < target:
		return min(current + delta, target)
	elif current > target:
		return max(current - delta, target)
	return current
