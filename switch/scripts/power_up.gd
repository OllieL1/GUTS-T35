extends Area2D

var speed: int = 550
var random_new_spawn: int
var nextCreated: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = randi_range(100, 500)  # Random X position within bounds
	position.y = randi_range(-1500,-2500)  # Start just above the top of the screen
	random_new_spawn = randi_range(15, 20)  # Random Y position to trigger the duplication
	add_to_group("powerup_group")  # Add to a group for easy access if needed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Only move and spawn new power-ups if the game is running
	if get_parent().run:
		position.y += speed * delta  # Move downwards

		if position.y > get_viewport().size.y + get_node("Score Up").get_rect().size.y and nextCreated == false:
			print("new created")
			nextCreated = true
			duplicate_powerup()
			queue_free()

# Function to duplicate this power-up and add the new one to the scene
func duplicate_powerup() -> void:
	var new_powerup = self.duplicate()  # Duplicate the current power-up
	new_powerup.position.y = -50  # Reset Y position for the new power-up
	new_powerup.position.x = randi_range(100, 500)  # Random X position for the new power-up
	get_parent().add_child(new_powerup)  # Add the new power-up to the scene

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_powerup(self)  # Call a method on the player to apply the shield effect
		duplicate_powerup()
		queue_free()  # Remove the power-up after collection
