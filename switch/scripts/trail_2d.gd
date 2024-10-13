extends Line2D

var trail_points = []  # Store the points of the trail
var max_points = 20  # Maximum points in the trail

func _process(delta: float) -> void:
	# Move existing points downward
	for i in range(len(trail_points)):
		trail_points[i].x += 1 * delta  # Adjust the speed as needed
		trail_points[i].y = 1200 - i*10
		#print(trail_points[i])


	# Remove the oldest point if too many points
	if len(trail_points) >= max_points:
		trail_points.pop_front()

	# Update Line2D's points array with trail_points after modification
	points = trail_points

func add_trail_point(new_point: Vector2) -> void:
	#print("TRAILING")  # Debug message
	trail_points.append(new_point)  # Add the new player position to the trail
	
	# Immediately update Line2D's points after adding the new point
	points = trail_points
