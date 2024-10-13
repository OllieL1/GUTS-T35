extends RichTextLabel

@onready var levelnode = get_node("/root/Level")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#testing comment

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (levelnode.run == true):
		modulate.a -= 0.01
