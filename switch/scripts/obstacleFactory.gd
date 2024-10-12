extends Node


func create_obstacle(typeOfObstacle,obstacleProperties):
	var obstacle
	match typeOfObstacle:
		"mid air":
			obstacle = preload("res://scripts/midAirObstacle.gd").new()
		# we can add more types of obstacles here
		_:
			print("Obstacle does not exist")
			return null
	return obstacle
