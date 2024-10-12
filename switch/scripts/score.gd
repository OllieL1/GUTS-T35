extends Label

var score = 0 ##getting from ally in player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (run == true):
		score_update
	pass

func score_update():
	##assign score here
	text = "Score: %s" % score
