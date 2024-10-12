extends Node2D

var speed : float = 250
var obstacle_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = randi_range(100, 500)
	position.y = -50
	add_to_group("obstacle_group")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	rotation += deg_to_rad(15)
	
	if position.y >= 850 and count_obstacles() <= 3:
		duplicate_obstacle()
		
	var obstacle_height = get_node("Sprite2D").get_rect().size.y  # Adjust this depending on how the obstacle's size is set
	if position.y > get_viewport().size.y + obstacle_height:
		queue_free()
	

# Function to duplicate this obstacle and add the new one to the scene
func duplicate_obstacle() -> void:
	var new_obstacle = self.duplicate()  # Duplicate the current obstacle
	new_obstacle.position = Vector2(randi_range(100, 500), -50)  # Spawn it at the top with random X position
	get_parent().add_child(new_obstacle)  # Add the new obstacle to the scene

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.apply_effect(self)
		
func count_obstacles() -> int:
	# Get the root node and iterate through its children
	for child in get_tree().get_nodes_in_group("obstacle_group"):
		obstacle_count += 1
	return obstacle_count
