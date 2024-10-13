extends Label

@onready var levelnode = get_node("/root/Level")
@onready var playernode = get_parent().get_node("Player")
var score : float = 0  # getting from ally in player
var score_multiplier : float = 1.0
var inc : float = 0.01


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate.a = 0
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# This should not call _on_Timer_timeout directly
	if levelnode and levelnode.run == true:
		modulate.a += 0.01
		update_score()  # You can handle other game logic here, but do not call _on_Timer_timeout()

func update_score() -> void:
	text = "Score: %s" % int(playernode.score)
