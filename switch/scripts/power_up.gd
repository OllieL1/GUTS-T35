extends Area2D

# Score multiplier for the power-up
var score_multiplier: float = 2.0

func _ready() -> void:
	position.x = 600  # Adjust starting position as needed
	position.y = 1000  # Adjust starting position as needed

func _process(delta: float) -> void:
	pass  # You can implement movement or logic here if needed

# This function is triggered when another body enters the area
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):  # Check if the colliding body is the player
		body.apply_powerup(self)  # Call the player's apply_powerup method
		queue_free()  # Remove the power-up after it is collected
