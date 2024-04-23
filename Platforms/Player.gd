extends CharacterBody2D

# Виртуальный игрок
# Комментарии ниже нужны для реального игрока
# этот код нигде не используется
# он не удален, так как его можно потом использовать в сцене с игрой
class Player:
	#var current_weapon_index: int = -1
	#var hp: float = 100.0
	#var damage: float = 0.0
	enum help_vector {} # Vector2
	
	#var player_speed: float = 300.0
	#var jump_velocity = -400.0
	
	var player_money: int = 0
	enum player_inventory {} # Weapon
	
	#var player_position_x # Нужен для перемещения игрока
	#var player_position_y # Может быть удалить	
	
	#enum enemies {} # Перенести в сцену карты
	
	#func _ready():
		#player_inventory = get_node("/root/MainMenu").player.player_inventory
		#player_inventory.add(Weapon.new().copy("Knife", 100, 50))
		
	#var gravity: float  = project_settings.get_setting("physics/2d/default_gravity").as_single();

'''
	func _physics_process(double delta):
		Vector2 velocity = Velocity;
		Vector2 v2 = Vector2();

		if not is_on_floor():
			velocity.y += gravity * delta;

		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = jump_velocity;
		if Input.is_action_just_pressed("move_down") and is_on_floor():
			position = new Vector2(position.x, position.y + 5);
		
		if Input.is_action_just_pressed("change_weapone") and inventory.count>1:
			if current_weapon_index == -1 or current_weapon_index == 0:
				current_weapon_index = 1;
				print(current_weapon_index);
			else if current_weapon_index == 1:
				current_weapon_index = 2;
				print(current_weapon_index);
			else if current_weapon_index == 2:
				current_weapon_index = 0;
				print(current_weapon_index);
		damage = inventory[current_weapon_index].damage;
		
		if input.is_action_just_pressed("melee_attack") and is_on_floor():
			for enemy in enemies:
				enemy.hp -= melee_damage;

		vector2 direction = Input.get_vector("ui_left", "ui_right", "ui_up", "move_down");
		
		if direction.x == 1 or direction.x == -1:
			velocity.x = direction.x * speed;
			v2.y = player_position_y;
			v2.x = player_position_x + 5 * direction.x;
			get_node<collision_shape_2d>("area_player/areacollision").position = v2;
		else if direction.x == 0:
			velocity.x = mathf.movetoward(velocity.x, 0, speed);
		
		velocity = velocity; # чзх
		move_and_slide();


	func _on_shooting_body_entered(Node2D body):
		if body != null:
			body.hp-=24;
			print("попадание");


	func body_entered(Node2D body):
		if body.get_type() == typeof(enemy1):
			if !enemies.contains((enemy1)body) and body != null:
				enemies.add(body);
			print("a");


	func body_exited(Node2D body):
		if body.get_type() == typeof(enemy1):
				if enemies.contains(body) and body != null:
					enemies.remove(body);
				print("b");
'''
