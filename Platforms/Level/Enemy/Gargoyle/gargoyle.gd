extends Enemy


func _on_ready():
	gravity = 450#ProjectSettings.get_setting("physics/2d/default_gravity")
	JUMP_VELOCITY = -300.0
	SPEED = 18.0
	damage = 30
	HP = 400
	delay = 4.5
