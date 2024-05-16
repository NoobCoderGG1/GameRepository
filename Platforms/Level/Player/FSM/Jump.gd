# Jump.gd
extends PlayerState
# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		#player.velocity.y = -player.JUMP_VELOCITY #Надо заменить на анимацию прыжка
		pass
func physics_update(delta: float) -> void:
	if player.is_Alive:
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
			elif Input.is_action_just_pressed("attack"):
				state_machine.transition_to("Attack")
			else:
				state_machine.transition_to("Run")
		
		if player.dirPlayer > 0:
			$"../../playerSprites/AnimationPlayer".current_animation = "jump_right"
		else:
			$"../../playerSprites/AnimationPlayer".current_animation = "jump_left"
