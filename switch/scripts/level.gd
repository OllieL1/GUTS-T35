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
	# Initialize by hiding the restart button
	$"Restart Button".visible = false
	waiting_for_start = true  # Waiting for player to start the game

# Main loop
func _process(delta: float) -> void:
	if run == true:
		# Add game logic here when the game is running
		pass

# Called when the play button is pressed to start the game (optional if keeping the button)
func _on_play_button_pressed() -> void:
	start_game()

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
		print(str(highscore))
		savefile(str(highscore))
	hsnode.HSdisplay()
	game_over_state = true  # Set game over state to true
	$"Restart Button".visible = false  # Optionally show the restart button

# Handle clicking anywhere on the screen to start or restart the game
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if waiting_for_start:
			# If waiting to start the game, a click will start the game
			start_game()
		elif game_over_state:
			# If game is over, a click will reset the game
			reset_game()

# Reset game state and reload the scene
func reset_game() -> void:
	run = false  # Stop the game
	game_over_state = false  # Reset the game over state
	waiting_for_start = true  # Waiting for the player to start again
	$"Play Button".visible = true  # Show the play button again for a fresh start
	$"Restart Button".visible = false  # Hide the restart button
	get_tree().reload_current_scene()  # Reload the current scene to reset everything
	
	
func savefile(content: String) -> void:
	var file = FileAccess.open("user://saved_high_score.txt", FileAccess.WRITE)
	if file:
		file.store_string(content)
	file.close()  # Always close the file after writing

func loadfile() -> String:
	var file = FileAccess.open("user://saved_high_score.txt", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		file.close()  # Always close the file after reading
		return content
	else:
		return "0"  # Return default value if the file doesn't exist
