extends Node2D

var speed : float = 450
var random_new_spawn : int
var nextCreated : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = randi_range(150, 570)
	position.y = -50
	random_new_spawn = randi_range(200, 700)
	add_to_group("obstacle_group")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().run:  # Check if the game is running
		position.y += speed * delta
		rotation += deg_to_rad(10)

		if position.y >= random_new_spawn and not nextCreated:
			nextCreated = true
			duplicate_obstacle()

		var obstacle_height = get_node("Sprite2D").get_rect().size.y  # Adjust this depending on how the obstacle's size is set
		if position.y > get_viewport().size.y + obstacle_height:
			queue_free()

# Function to duplicate this obstacle and add the new one to the scene
func duplicate_obstacle() -> void:
	var new_obstacle = self.duplicate()  # Duplicate the current obstacle
	new_obstacle.position = Vector2(randi_range(100, 500), -50)  # Spawn it at the top with a random X position
	get_parent().add_child(new_obstacle)  # Add the new obstacle to the scene

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_effect(self)
