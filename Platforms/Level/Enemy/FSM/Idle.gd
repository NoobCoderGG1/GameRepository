#Idle.gd
class_name enemyIdle
extends enemyState

func enter(_msg := {}) -> void:
	enemy.velocity = Vector2.ZERO
func physics_update(_delta: float) -> void:
	if not enemy.is_on_floor():
		state_machine.transition_to("Jump")
		return
	'''if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump", {do_jump = true}) '''
	if enemy.velocity.x > 1 or enemy.velocity.x < -1:
		state_machine.transition_to("Run")
		
	enemy.animation.play("idle")
	enemy.animation.flip_h = enemy.dirEnemy < 0

