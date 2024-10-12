extends CharacterBody2D

# Movement variables
var speed: float = 700
var acceleration: float = 1800
var deceleration: float = 1200
var target_velocity: Vector2 = Vector2.ZERO
var moving_left: bool = false
var score_multiplier: float = 1.0  # Initial score multiplier
var score: float = 0

func _ready() -> void:
	position.x = 360  # Adjust starting position as needed
	position.y = 1000  # Adjust starting position as needed
	add_to_group("player")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				toggle_direction()

func toggle_direction() -> void:
	moving_left = !moving_left

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

	self.velocity = velocity
	move_and_slide()  # Handle movement and sliding

func move_toward(current: float, target: float, delta: float) -> float:
	if current < target:
		return min(current + delta, target)
	elif current > target:
		return max(current - delta, target)
	return current

# Method to apply the power-up effect
func apply_powerup(powerup: Node) -> void:
	score_multiplier *= powerup.score_multiplier  # Increase the multiplier
	print("New Score Multiplier: ", score_multiplier)  # Debug output
	
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("powerups"):  # Check if the collided body is a power-up
		apply_powerup(body)  # Apply the power-up
		body.queue_free()  # Remove the power-up from the scene
