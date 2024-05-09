# Jump.gd
extends PlayerState
# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		#player.velocity.y = -player.JUMP_VELOCITY #Надо заменить на анимацию прыжка
		pass
func physics_update(delta: float) -> void:
	# Horizontal movement.
	var input_direction_x: float = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	#Совершить какие-то действия с анимацией падения
	
	# Landing.
	if player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	player.animation.play("player_jump")
	player.animation.flip_h = player.dirPlayer < 0
