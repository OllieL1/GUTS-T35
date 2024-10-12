extends Node2D

var speed : float = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = 200
	position.y = -50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	rotation += deg_to_rad(15)
		
#func create_obstacles() -> void:
	
func _on_body_entered(body: Node2D) -> void:
	print("Fuck")
	if body.is_in_group("player"):
		body.apply_effect(self)
