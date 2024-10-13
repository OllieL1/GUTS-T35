extends Area2D

# Score multiplier for the power-up
var score_multiplier: float = 10.0
var speed: int = 700
var random_new_spawn: int
var nextCreated: bool = false

@onready var scorenode = get_node("/root/Level")

func _ready() -> void:
	position.x = randi_range(100, 500)  # Random X position within bounds
	position.y = randi_range(-1500, -3000)  # Start just above the top of the screen
	random_new_spawn = randi_range(15, 20)  # Random Y position to trigger the duplication
	add_to_group("powerup_group")  # Add to a group for easy access if needed

func _process(delta: float) -> void:
	# Only move and spawn new power-ups if the game is running
	if get_parent().run:
		position.y += speed * delta  # Move downwards

		if position.y > get_viewport().size.y + get_node("Sprite2D").get_rect().size.y and nextCreated == false:
			nextCreated = true
			duplicate_powerup()
			queue_free()

# Function to duplicate this power-up and add the new one to the scene
func duplicate_powerup() -> void:
	var new_powerup = self.duplicate()  # Duplicate the current power-up
	new_powerup.position.x = randi_range(100, 500)  # Random X position for the new power-up
	get_parent().add_child(new_powerup)  # Add the new power-up to the scene

# This function is triggered when another body enters the area
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):  # Check if the colliding body is the player
		body.apply_double(self)  # Call the player's apply_powerup method
		queue_free()  # Remove the power-up after it is collected
