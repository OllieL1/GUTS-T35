extends Node2D

# Reference to the GPUParticles2D node
@onready var firework_particles = GPUParticles2D.new()

func _ready() -> void:
	setup_firework_particles()
	# Trigger the firework effect
	firework_particles.emitting = true

func setup_firework_particles() -> void:
	# Add the particles to the current node
	add_child(firework_particles)

	# Basic Properties
	firework_particles.amount = 200  # Number of particles emitted
	firework_particles.one_shot = true  # Emit all at once
	firework_particles.lifetime = 1.5  # Duration of particles

	# Set Emission Rate
	firework_particles.emission_rate = 0  # Emit all particles at once

	# Adjust the Particle Parameters
	firework_particles.initial_velocity = 400  # Speed of particles
	firework_particles.direction = Vector2(0, -1)  # Particles move upwards
	firework_particles.spread = 360  # Particles explode in all directions
	firework_particles.gravity = Vector2(0, -50)  # Optional downward pull

	# Modify Scale and Color
	firework_particles.scale = Vector2(1, 1)  # Initial size scaling
	firework_particles.scale_random = 0.5  # Size variation

	# Set Color Gradient
	var color_gradient = Gradient.new()
	color_gradient.add_color(0.0, Color(1, 1, 0))  # Bright yellow
	color_gradient.add_color(0.5, Color(1, 0.5, 0))  # Orange
	color_gradient.add_color(1.0, Color(1, 0, 0))  # Red
	firework_particles.color = color_gradient

	# Set Scale over Lifetime
	var scale_curve = Curve.new()
	firework_particles.scale_curve = scale_curve

	# Additional Settings
	firework_particles.velocity_random = 0.5  # Slight variation in speed
	firework_particles.fade = true  # Enable fading

	# Position the particles at the desired explosion point
	firework_particles.position = position  # Adjust as necessary
