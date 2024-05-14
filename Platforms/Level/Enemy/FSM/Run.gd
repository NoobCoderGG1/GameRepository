# Run.gd
extends enemyState
func physics_update(delta: float) -> void:
	# Notice how we have some code duplication between states. That's inherent to the pattern,
	# although in production, your states will tend to be more complex and duplicate code
	# much more rare.
	if not enemy.is_on_floor():
		state_machine.transition_to("Jump")
		return
	# We move the run-specific input code to the state.
	# A good alternative would be to define a `get_input_direction()` function on the `Player.gd`
	# script to avoid duplicating these lines in every script.
	#Совершить какие-то действия с анимацией

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump", {do_jump = true})
	elif is_equal_approx(enemy.velocity.x, 0.0):
		state_machine.transition_to("Idle")
	enemy.animation.play("enemy_run")
	enemy.animation.flip_h = enemy.dirEnemy < 0
