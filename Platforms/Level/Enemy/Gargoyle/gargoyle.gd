extends Enemy


func _on_ready():
	gravity = 450#ProjectSettings.get_setting("physics/2d/default_gravity")
	JUMP_VELOCITY = -300.0

