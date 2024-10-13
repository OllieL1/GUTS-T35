extends CharacterBody2D

# Movement variables
var speed: float = 700
var acceleration: float = 2000
var deceleration: float = 2000
var target_velocity: Vector2 = Vector2.ZERO
var moving_left: bool = false
var score_multiplier: float = 1.0  # Initial score multiplier
var score: float = 0
var multiplier_duration: float = 5.0
var invincible: bool = false

@onready var levelnode = get_node("/root/Level")
@onready var scorenode = get_parent().get_node("Score")
@onready var trailnode = get_node("Trail2D")
@onready var multiplier_timer = $Timer  # Reference to the Timer node
@onready var explosion_particles = get_parent().get_node("ExplosionParticles")  # Adjusted path to reference particles
@onready var invincibility_timer = $InvincibilityTimer  # Reference to the Invincibility Timer
@onready var sprite = $Sprite2D  # Change this to your actual sprite node name

var original_texture: Texture  # Variable to hold the original texture

func _ready() -> void:
	print(levelnode.run)
	position.x = 360  # Adjust starting position as needed
	position.y = 1000  # Adjust starting position as needed
	add_to_group("player")
	explosion_particles.emitting = false  # Ensure particles do not emit at start
	original_texture = sprite.texture  # Store the original texture

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			toggle_direction()
	elif event is InputEventKey and event.keycode == KEY_SPACE:
		if event.pressed:
			toggle_direction()



func toggle_direction() -> void:
	moving_left = !moving_left

func _process(delta: float) -> void:
	if levelnode.run:
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
		trailnode.add_trail_point(self.position)

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
	invincible = true
	var invincible_texture = load("res://art/invincible.png")  # Ensure this path is correct
	change_texture(invincible_texture)  # Change to the invincibility texture
	invincibility_timer.start()  # Start the invincibility timer
	
func apply_double(powerup: Node) -> void:
	score_multiplier *= powerup.score_multiplier  # Increase the multiplier  # Debug output
	multiplier_timer.start() 

func play_explosion() -> void:
	explosion_particles.position = position  # Set position relative to player
	explosion_particles.show()  # Ensure particles are visible
	self.visible = false  # Hide the player
	trailnode.visible = false  # Hide the trail  # Start emitting particles
	explosion_particles.emitting = true

	await get_tree().create_timer(0.2).timeout  # Wait for 2 seconds
	explosion_particles.emitting = false  # Stop emitting particles
	explosion_particles.hide()  # Optionally hide particles after use
  
func change_texture(new_texture: Texture) -> void:
	if new_texture:  # Check if the texture is valid
		sprite.texture = new_texture  # Change the texture of the sprite
		print("Texture changed successfully.")
	else:
		print("Failed to load new texture.")

func apply_effect(obstacle: Node) -> void:
	if not invincible:
		play_explosion()  # Play the explosion effect
		var level_script = get_parent()  # Get the parent node (Level)
		level_script.game_over() 

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("powerups"):  # Check if the collided body is a power-up
		apply_powerup(body)  # Apply the power-up
		body.queue_free()  # Remove the power-up from the scene

func _on_timer_timeout() -> void:
	print("TIMEOUT")
	score_multiplier = 1.0  # Reset to 1x multiplier
	print("Multiplier reset to 1x")  # Debug output

func _on_invincibility_timer_timeout() -> void:
	invincible = false  # Reset invincibility status
	change_texture(original_texture)  # Change back to the original texture
	print("Invincibility expired")  # Debug output
