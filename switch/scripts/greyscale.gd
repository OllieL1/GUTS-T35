extends ColorRect

@onready var levelnode = get_node("/root/Level")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grey_reset()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if levelnode.game_over_state == true and modulate.a < 0.5:
		modulate.a += 0.01
	pass

func grey_reset() -> void:
	while modulate.a > 0:
		modulate.a -= 0.1
