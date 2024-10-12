extends Label

@onready var levelnode = get_node("/root/Level")
var score : float = 0  # getting from ally in player
var inc : float = 0.01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# This should not call _on_Timer_timeout directly
	if levelnode and levelnode.run == true:
		_on_timer_timeout()  # You can handle other game logic here, but do not call _on_Timer_timeout()

func _on_timer_timeout() -> void:
	# Increment score every second based on the Timer's signal
	score += 0.1
	if (int(score*10) % 10 == 0):
		text = "Score: %s" % int(score)
