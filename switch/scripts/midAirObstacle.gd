extends "res://scripts/obstacle.gd"

var spinRate : float


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(delta):
	rotation += deg_to_rad(spinRate * delta) # rotation is property 
