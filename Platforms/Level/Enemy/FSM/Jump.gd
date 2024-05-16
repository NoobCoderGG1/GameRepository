#Jump.gd
class_name enemyJump
extends enemyState

# If we get a message asking us to jump, we jump.
func enter(msg := {}) -> void:
	if msg.has("do_jump"):
		#enemy.velocity.y = -enemy.JUMP_VELOCITY #Надо заменить на анимацию прыжка
		pass
func physics_update(delta: float) -> void:
	# Horizontal movement.
	#Совершить какие-то действия с анимацией падения
	# Landing.
	if enemy.is_on_floor():
		if is_equal_approx(enemy.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
	enemy.animation.play("jump")
	enemy.animation.flip_h = enemy.dirEnemy < 0
