extends Node2D

var base_speed: float = 450  # Base speed for obstacles
var speed_increment: float = 2  # How much the speed should increase with each new obstacle
var max_speed: float = 800  # Maximum speed cap for obstacles
var speed: float = base_speed  # Initialize speed to the base speed
var random_new_spawn: int
var nextCreated: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = randi_range(150, 570)
	position.y = -50
	random_new_spawn = randi_range(100, 700)
	add_to_group("obstacle_group")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent().run:  # Check if the game is running
		position.y += speed * delta
		rotation += deg_to_rad(10)

		if position.y >= random_new_spawn and not nextCreated:
			nextCreated = true
			duplicate_obstacle()

		var obstacle_height = get_node("Sprite2D").get_rect().size.y
		if position.y > get_viewport().size.y + obstacle_height:
			queue_free()

# Function to duplicate this obstacle and add the new one to the scene
func duplicate_obstacle() -> void:
	var new_obstacle = self.duplicate()  # Duplicate the current obstacle
	new_obstacle.position = Vector2(randi_range(100, 500), -50)  # Spawn it at the top with a random X position
	new_obstacle.set_speed(speed + speed_increment)  # Increase the speed for the new obstacle
	print(new_obstacle.speed)
	get_parent().add_child(new_obstacle)  # Add the new obstacle to the scene

# Function to set speed dynamically with a maximum speed cap
func set_speed(new_speed: float) -> void:
	speed = min(new_speed, max_speed)  # Ensure speed does not exceed max_speed

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_effect(self)
