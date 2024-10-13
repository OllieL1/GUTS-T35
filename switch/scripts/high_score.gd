extends RichTextLabel

@onready var levelnode = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if levelnode and levelnode.run == false:
		update_highscore()
	if levelnode.run == true:
		modulate.a -= 0.01

func update_highscore() -> void:
	text = "[center]High Score: %s" % int(levelnode.highscore)
	
func HSdisplay() -> void:
	modulate.a = 100
