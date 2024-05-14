#Attack.gd
extends PlayerState

func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
		return
	var input_direction_x: float = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	#Совершить какие-то действия с анимацией
	if player.pressedAttack:
		if player.inventory[player.currentWeaponIndex].type == "ranged":
			if player.dirPlayer > 0:
				$"../../playerSprites/AnimationPlayer".current_animation = "shoot_right"
			else:
				$"../../playerSprites/AnimationPlayer".current_animation = "shoot_left"
		else:
			if player.dirPlayer > 0:
				$"../../playerSprites/AnimationPlayer".current_animation = "attack_right"
			else:
				$"../../playerSprites/AnimationPlayer".current_animation = "attack_left"
	else:
		if Input.is_action_just_pressed("jump"):
			state_machine.transition_to("Jump", {do_jump = true})
		elif is_equal_approx(input_direction_x, 0.0):
			state_machine.transition_to("Idle")
		elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			state_machine.transition_to("Run")
