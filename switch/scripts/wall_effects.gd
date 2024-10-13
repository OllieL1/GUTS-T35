extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				toggleWall()
				
func toggleWall():
	var rightParticles = $"Right Wall Effects/RightParticles"
	var leftParticles = $"Left Wall Effects/LeftParticles"
	var rightGlow = $"Right Wall Effects/RightGlow"
	var leftGlow = $"Left Wall Effects/LeftGlow"
	var rightLightGlow = $"Right Wall Effects/RightLightGlow"
	var leftLightGlow = $"Left Wall Effects/LeftLightGlow"
	leftParticles.emitting=!leftParticles.emitting
	rightParticles.emitting=!rightParticles.emitting
	leftGlow.visible=!leftGlow.visible
	rightGlow.visible=!rightGlow.visible
	leftLightGlow.visible=!leftLightGlow.visible
	rightLightGlow.visible=!rightLightGlow.visible
