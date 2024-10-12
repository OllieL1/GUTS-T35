extends CharacterBody2D

# Movement variables
var speed: float = 700
var acceleration: float = 1800
var deceleration: float = 1200
var target_velocity: Vector2 = Vector2.ZERO
var moving_left: bool = false
var score_multiplier: float = 1.0  # Initial score multiplier
var score: float = 0
var multiplier_duration: float = 5.0

@onready var levelnode = get_node("/root/Level")
@onready var scorenode = get_parent().get_node("Score")
@onready var multiplier_timer = $Timer  # Reference to the Timer node

func _ready() -> void:
	print("Bitch")
	print(levelnode.run)
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
	if(levelnode.run):
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
		move_and_slide() 
		inc_score()  # Increment score

func move_toward(current: float, target: float, delta: float) -> float:
	if current < target:
		return min(current + delta, target)
	elif current > target:
		return max(current - delta, target)
	return current

func inc_score() -> void:
	score += 0.1 * score_multiplier
	if (int(score * 10) % 10 == 0):
		scorenode.update_score()

# Method to apply the power-up effect
func apply_powerup(powerup: Node) -> void:
	score_multiplier *= powerup.score_multiplier  # Increase the multiplier  # Debug output
	print("New Score Multiplier: ", score_multiplier)
	multiplier_timer.start() 
	print("TIMER START") # Start the timer when a power-up is applied


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("powerups"):  # Check if the collided body is a power-up
		apply_powerup(body)  # Apply the power-up
		body.queue_free()  # Remove the power-up from the scene


func _on_timer_timeout() -> void:
	print("TIMEOUT")
	score_multiplier = 1.0  # Reset to 1x multiplier
	print("Multiplier reset to 1x")  # Debug output
