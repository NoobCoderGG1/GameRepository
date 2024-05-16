#Attack.gd
extends PlayerState
@onready var startAnim : float = 0.0 #Время начала анимации атаки

func physics_update(delta: float) -> void:
	if player.is_Alive:
		if not player.is_on_floor():
			state_machine.transition_to("Jump")
			return
		if Input.is_action_just_pressed("jump"):
			state_machine.transition_to("Jump", {do_jump = true})
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
				state_machine.transition_to("Run")
		if(Input.is_anything_pressed()==false):
			state_machine.transition_to("Idle")
		#Совершить какие-то действия с анимацией
		if player.inventory[player.currentWeaponIndex].type == "ranged":
			if player.dirPlayer > 0:
				$"../../playerSprites/AnimationPlayer".current_animation = "shoot_right"
			else:
				$"../../playerSprites/AnimationPlayer".current_animation = "shoot_left"
		elif player.inventory[player.currentWeaponIndex].type == "melee":
			if player.timerNode.time_counter - startAnim > 1.5:
				startAnim = player.timerNode.time_counter
				if player.dirPlayer > 0:
					$"../../playerSprites/AnimationPlayer".current_animation = "attack_right"
				else:
					$"../../playerSprites/AnimationPlayer".current_animation = "attack_left"
		elif player.inventory[player.currentWeaponIndex].type == "lazer":
			if player.timerNode.time_counter - startAnim > 1.5:
				startAnim = player.timerNode.time_counter
				if player.dirPlayer > 0:
					$"../../playerSprites/AnimationPlayer".current_animation = "shoot_right"
				else:
					$"../../playerSprites/AnimationPlayer".current_animation = "shoot_left"
	 
		
