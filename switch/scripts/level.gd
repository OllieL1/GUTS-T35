extends Node2D

var run = false
#test

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	### load main screen with overlay (title, high score, user, player sprite)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# main loop
	if (run == true):
		
		pass
	pass


func _on_play_button_pressed() -> void:
	run = true
	$"Play Button".visible = false
