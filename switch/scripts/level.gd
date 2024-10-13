extends Node2D

@onready var playernode = get_node("Player")
@onready var hsnode = get_node("High Score")
var run = false  # Tracks if the game is running
var game_over_state = false  # Tracks if the game is over
var waiting_for_start = true  # Tracks if we're waiting for the player to start the game
var highscore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	highscore = loadfile()
	$"Restart Button".visible = false  # Hide the restart button initially
	waiting_for_start = true  # Waiting for player to start the game

# Main loop
func _process(delta: float) -> void:
	pass

# Starts or restarts the game
func start_game() -> void:
	run = true  # Set the game to running state
	game_over_state = false  # Reset the game over state
	waiting_for_start = false  # No longer waiting for the game to start
	$"Play Button".visible = false  # Hide the play button when the game starts
	$"Restart Button".visible = false  # Ensure restart button is hidden when the game starts

# Called to trigger game over and display the restart option
func game_over() -> void:
	run = false  # Stop the game
	if playernode.score > int(highscore):
		highscore = playernode.score
		savefile(str(highscore))  # Save the new high score
	hsnode.HSdisplay()
	game_over_state = true  # Set game over state to true
	$"Restart Button".visible = false  # Optionally show the restart button

# Handle clicking anywhere on the screen to start or restart the game
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if waiting_for_start:
			start_game()
		elif game_over_state:
			reset_game()

	elif event is InputEventKey and event.keycode == KEY_SPACE and event.pressed:
		if waiting_for_start:
			start_game()
		elif game_over_state:
			reset_game()


# Reset game state and reload the scene
func reset_game() -> void:
	run = false
	game_over_state = false
	waiting_for_start = true
	$"Play Button".visible = true
	$"Restart Button".visible = false
	get_tree().reload_current_scene()

# Save the high score to a file
func savefile(content: String) -> void:
	var file = FileAccess.open("user://saved_high_score.txt", FileAccess.WRITE)
	if file:
		file.store_string(content)
		file.close()  # Always close the file after writing

# Load the high score from a file
func loadfile() -> String:
	var file = FileAccess.open("user://saved_high_score.txt", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()  # Always close the file after reading
		return content
	else:
		return "0"  # Return default value if the file doesn't exist
