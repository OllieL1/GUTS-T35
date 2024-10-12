extends "res://scripts/obstacle.gd"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("obstacle")
	print("HELLO")
	
func _on_body_entered(body: Node2D) -> void:
	print("Fuck")
	if body.is_in_group("player"):
		body.apply_effect(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
