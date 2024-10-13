extends CharacterBody2D

var speed: float = 700
var acceleration: float = 2000
var deceleration: float = 2000
var target_velocity: Vector2 = Vector2.ZERO
var moving_left: bool = false
var score_multiplier: float = 1.0
var score: float = 0
var multiplier_duration: float = 5.0
var invincible: bool = false

@onready var levelnode = get_node("/root/Level")
@onready var scorenode = get_parent().get_node("Score")
@onready var trailnode = get_node("Trail2D")
@onready var multiplier_timer = $Timer
@onready var explosion_particles = get_parent().get_node("ExplosionParticles")
@onready var invincibility_timer = $InvincibilityTimer
@onready var warning_timer = $WarningTimer
@onready var sprite = $Sprite2D

var original_texture: Texture
var invincible_texture: Texture = load("res://art/invincible.png")
var warning_texture: Texture = load("res://art/warning-shield.png")

func _ready() -> void:
	print(levelnode.run)
	position.x = 360
	position.y = 1000
	add_to_group("player")
	explosion_particles.emitting = false
	original_texture = sprite.texture

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
		inc_score()
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

func apply_powerup(powerup: Node) -> void:
	invincible = true
	change_texture(invincible_texture)
	invincibility_timer.start(5.0)
	warning_timer.start(4.0)
	
func apply_double(powerup: Node) -> void:
	score_multiplier *= powerup.score_multiplier
	multiplier_timer.start()

func play_explosion() -> void:
	explosion_particles.position = position
	explosion_particles.show()
	self.visible = false
	trailnode.visible = false
	explosion_particles.emitting = true

	await get_tree().create_timer(0.2).timeout
	explosion_particles.emitting = false
	explosion_particles.hide()
  
func change_texture(new_texture: Texture) -> void:
	if new_texture:
		sprite.texture = new_texture
		print("Texture changed successfully.")
	else:
		print("Failed to load new texture.")

func apply_effect(obstacle: Node) -> void:
	if not invincible:
		play_explosion()
		var level_script = get_parent()
		level_script.game_over()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("powerups"):
		apply_powerup(body)
		body.queue_free()

func _on_timer_timeout() -> void:
	print("TIMEOUT")
	score_multiplier = 1.0
	print("Multiplier reset to 1x")

func _on_invincibility_timer_timeout() -> void:
	invincible = false
	change_texture(original_texture)

func _on_warning_timer_timeout() -> void:
	change_texture(warning_texture)
