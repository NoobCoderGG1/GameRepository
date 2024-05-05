# Jump.gd
extends PlayerState
# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse #Надо заменить на анимацию прыжка
func physics_update(delta: float) -> void:
	# Horizontal movement.
	var input_direction_x: float = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	#Совершить какие-то действия с анимацией падения
	$"../../AnimatedSprite2D".animation = "player_jump"
	print("Анимация прыжка и направление: " + str(input_direction_x))
	# Landing.
	if player.is_on_floor():
		if is_equal_approx(input_direction_x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
