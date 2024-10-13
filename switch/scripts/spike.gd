extends Node2D

var speed: int = 250
var nextCreated: bool = false
var random_new_spawn: int
var min_spawn_range: int = 100  # Minimum possible spawn range
var max_spawn_range: int = 600  # Maximum initial spawn range
var spawn_range_decrease: int = 3 # Amount to decrease the range each time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Randomly decide whether to go left or right
	random_new_spawn = randi_range(min_spawn_range, max_spawn_range)
	if randi() % 2 == 0:  # Randomly pick between 0 and 1
		position.x = 0  # Going left
		rotation = 0
	else:
		position.x = get_viewport().size.x  # Position near the right wall
		rotation = deg_to_rad(180)

	position.y = -100
	add_to_group("spikes_group")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().run:  # Check if the game is running
		position.y += speed * delta
		
		if position.y >= random_new_spawn and not nextCreated:
			nextCreated = true
			duplicate_obstacle()
		
		var obstacle_height = get_node("Sprite2D").get_rect().size.y  # Adjust this depending on how the obstacle's size is set
		if position.y > get_viewport().size.y + obstacle_height:
			queue_free()

# Function to duplicate this obstacle and add the new one to the scene
func duplicate_obstacle() -> void:
	var new_obstacle = self.duplicate()  # Duplicate the current spike
	new_obstacle.position = Vector2(randi_range(100, 500), -50)  # Spawn it at the top with a random X position
	get_parent().add_child(new_obstacle)  # Add the new spike to the scene
	
	# Decrease the spawn range progressively but ensure it doesn't go below the minimum range
	if max_spawn_range > min_spawn_range + spawn_range_decrease:
		max_spawn_range -= spawn_range_decrease
	
	# Generate the next random spawn location with the updated range
	random_new_spawn = randi_range(min_spawn_range, max_spawn_range)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_effect(self)
