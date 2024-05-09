#Idle.gd
extends PlayerState

func enter(_msg := {}) -> void:
	player.velocity = Vector2.ZERO
func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Jump")
		return
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump", {do_jump = true})
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run")
	player.animation.play("player_idle")
	player.animation.flip_h = player.dirPlayer < 0

