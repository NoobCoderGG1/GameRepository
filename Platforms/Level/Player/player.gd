class_name Player
extends CharacterBody2D
#Переменные игрока
@onready var player = $"."
var is_Alive = true #Переменная, которая показывает, что игрок живой
var pressedAttack = false #Переменная для того, чтобы определить зажата ли кнопка атаки
var currentWeaponIndex = 0
var HP = 100
var damage: int = 0 #Не достал оружие.
var helpVector = [] #Vector2 
var SPEED: float = 300.0
var JUMP_VELOCITY: float = -400.0
var countMoney:int = 0;
var inventory = [] #Weapones
var dirPlayer = 1 #Направление взгляда персонажа, равняется -1 или 1
#Координаты смещения зоны "радиуса атаки ближнего боя" от самого героя
var PosX:float; 
var PosY:float;
var enemies = []
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Переменные необходимые для lazerGun стрельбы
var area_lazerGun : CollisionShape2D
@onready var timerNode = $"../UI/timerCount"
var timeNow
var offset : float
#Переменные необходимые для commonShoot стрельбы
var realPlayer
var dt #как timeNow, но для commonShoot
var area_commonshoot
var isMegaWeapon=false #Для огромной лазерной пушки

func _ready():
	inventory = get_tree().root.get_node("main_menu").virtual_player.player_inventory
	var weapon_class = ResourceLoader.load("res://Weapon.gd")
	if get_tree().root.get_node("main_menu").virtual_player.weapon_count < 3:
		var tmp_weapon = weapon_class.Weapon.new()
		tmp_weapon.icon = "res://UI/assets/Weapons/StoneSword.png";tmp_weapon.name = "Knife";	
		tmp_weapon.fire_rate = 100;	tmp_weapon.damage = 50.0;
		tmp_weapon.capacity = -1;
		tmp_weapon.current_bullet = -1;
		tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(0.370,0.370);
		inventory.append(tmp_weapon)
	$playerSprites/currentWeapon.texture = load(inventory[currentWeaponIndex].icon)
	$playerSprites/currentWeapon.scale = inventory[currentWeaponIndex].textureSize
	damage = inventory[currentWeaponIndex].damage
	PosX = $AreaPlayer/AreaCollision.position.x
	PosY = $AreaPlayer/AreaCollision.position.y
	#Инициализация переменных для lazerGun стрельбы
	area_lazerGun = player.get_node("Shooting").get_node("CollisionShape2D")
	area_lazerGun.visible = false
	timeNow = timerNode.time_counter
	#Инициализация переменных для commonShoot стрельбы
	realPlayer = get_tree().root.get_node("Level").get_node("player")
	dt = timerNode.time_counter

func _physics_process(delta):
	if HP <= 0 and is_Alive:
		is_Alive = false
		$LazerGunLine.clear_points()
		var total_time = "%02d" % timerNode.min + ":" + "%02d" % timerNode.sec
		$"../UI/endGame".visible = true
		$"../UI/endGame/Label".text = "You Died!\n" + "Time:" + total_time + "\n" + "Coins: " + str(countMoney) + "X" + str(timerNode.min)
		$playerSprites.visible = false
		$playerDied.visible = true
		$playerDied.play("player_died")
		return
	if HP <= 0:
		return
	isMoving(delta)
	changeWeapon()
	player_attack()
	#Для LazerGun, чтобы луч пропадал через время
	if timerNode.time_counter - timeNow >= 0.2:
		area_lazerGun.visible = false
		area_lazerGun.shape.b = Vector2(0, 0)
		timeNow = timerNode.time_counter
		$LazerGunLine.clear_points()
	
func isMoving(delta):
	var Velocity : Vector2 = velocity
	var dirAreaPlayer : Vector2 = Vector2() #Направление взгляда героя для AreaPlayer
	# Add the gravity.
	if not is_on_floor():
		Velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		Velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("move_down") and is_on_floor():
		position = Vector2(position.x, position.y + 5);

	var direction = Input.get_vector("move_left","move_right","ui_page_up","ui_page_up") #Последнии два действия как объекты пустышки, ни на что не влияет
	if direction.x == 1 or direction.x == -1:
			Velocity.x = direction.x * SPEED;
			dirAreaPlayer.y = PosY;
			dirAreaPlayer.x = PosX + 5 * direction.x; #Перемещение "области досягаемости атаки" персонажа
			$AreaPlayer/AreaCollision.position = dirAreaPlayer;
			dirPlayer = direction.x
	if direction == Vector2.ZERO:
			Velocity.x = move_toward(velocity.x, 0, SPEED);
	velocity = Velocity;
	move_and_slide();

func changeWeapon():
	if Input.is_action_just_pressed("change_weapon") and inventory.size() > 1:
		match currentWeaponIndex:
			0:
				currentWeaponIndex = 1
			1:
				if inventory.size() < 3:
					currentWeaponIndex = 0
				else:
					currentWeaponIndex = 2
			2:
				currentWeaponIndex = 0
		damage = inventory[currentWeaponIndex].damage
		if inventory[currentWeaponIndex].icon == null:
			$playerSprites/currentWeapon.texture = null
			return
		$playerSprites/currentWeapon.texture = load(inventory[currentWeaponIndex].icon)
		$playerSprites/currentWeapon.scale = inventory[currentWeaponIndex].textureSize
		if inventory[currentWeaponIndex].icon == "res://UI/assets/Weapons/LaserGun.png":
			isMegaWeapon = true
		else: 
			isMegaWeapon = false
		if inventory[currentWeaponIndex].current_bullet == 0:
			$playerSprites/reloadAttention.visible = true
		else:
			$playerSprites/reloadAttention.visible = false
					
func player_attack():
	if inventory[currentWeaponIndex].current_bullet == 0:
		$playerSprites/reloadAttention.visible = true
		if timerNode.time_counter - dt > 3.5:
			inventory[currentWeaponIndex].current_bullet = inventory[currentWeaponIndex].capacity
			$playerSprites/reloadAttention.visible = false
	if Input.is_action_just_released("attack"):
		pressedAttack = false
	if Input.is_action_just_pressed("attack") and (inventory[currentWeaponIndex].type == "melee" or inventory[currentWeaponIndex].type == "lazer"):
		pressedAttack = true
		if inventory[currentWeaponIndex].type == "lazer":
			lazerShoot()
		if is_on_floor() and inventory[currentWeaponIndex].type == "melee":  #Урон по области, если в руках оружие ближнего боя
			for enemy in enemies:
				enemy.HP -= damage
				print(enemy.HP)
		return
	if Input.is_action_just_pressed("attack") or pressedAttack:
		if inventory[currentWeaponIndex].type == "ranged":
			if inventory[currentWeaponIndex].name != "LazerGun" or inventory[currentWeaponIndex].name != "DragonFire" or inventory[currentWeaponIndex].name != "Stick":
				pressedAttack = true
				commonShoot()

func areaPlayer_entered(body): #Заносит врагов в список, если они попали в область действия оружия ближнего боя
	if not enemies.has(body) and body != null:
		enemies.append(body)
func areaPlayer_exited(body): #Выносит из списка
	if enemies.has(body) and body != null:
		enemies.erase(body)
		
func shootingBody_entered(body): #Функция для lazerShoot
	if body != null:
		body.HP -= damage
#Функции осуществляющие стрельбу
func lazerShoot():
	for i in range(0, 20*16, 16):
		if isMegaWeapon: break
		if check_tile(player.position.x, player.position.y, i * dirPlayer): #Проверка на tile
			fire(float(i * dirPlayer - fmod(player.position.x, 16.0) + 0)) 
			return
	fire(400 * dirPlayer)
	
func commonShoot():
	var indx = get_tree().root.get_node("Level").get_node("player").currentWeaponIndex
	var weapon = inventory[indx] #Получение текущего оружия игрока
	var fr = weapon.fire_rate
	if timerNode.time_counter - dt < fr / 1000.0: #TimeSpan(0, 0, int(fr / 60000), int(fr / 1000), int(fr % 1000); Для регулировки скорости атаки
		return
	if indx == -1:
		return
	if inventory[indx].current_bullet == 0:
		return
	dt = timerNode.time_counter
	#Создание коллизии пули
	var segment := SegmentShape2D.new()
	segment.a = Vector2(0,0)
	segment.b = Vector2(5,5)
	var collision := CollisionShape2D.new()
	collision.debug_color = Color(255, 0, 0, 1)
	collision.shape = segment
	#Создание узла спрайта для пули
	var bullet_sprite := Sprite2D.new()
	bullet_sprite.texture = load(inventory[indx].bulletTexture)
	bullet_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	bullet_sprite.scale = Vector2(0.35,0.35)
	bullet_sprite.flip_h = dirPlayer < 0
	#Создание пули и ее размещение в узле "Level"
	area_commonshoot = Area2D.new()
	area_commonshoot.name = inventory[indx].name + "~" + str(inventory[indx].current_bullet) + "^" + str(dirPlayer)
	var area_commonshoot_name = str(area_commonshoot.name) #Получение имени пули для правильного обращения через get_node 
	var area_commonshoot_copy = area_commonshoot #Получение копии для корректной работы с ссылками
	var lambda = func(body): 
		var index = get_tree().root.get_node("Level").get_node("player").currentWeaponIndex
		if body is CharacterBody2D or body is TileMap or body is StaticBody2D:
			if body is CharacterBody2D:
				print("")
				print(body.HP)
				body.HP -= realPlayer.damage
				print(body.HP)
				get_tree().root.get_node("Level").bullets.erase(area_commonshoot_copy)
				deleteScene(area_commonshoot_name)
			elif body is TileMap or body is StaticBody2D:
				get_tree().root.get_node("Level").bullets.erase(area_commonshoot_copy)
				deleteScene(area_commonshoot_name)
	#Продолжение установки свойств для пули
	area_commonshoot.body_entered.connect(lambda)
	area_commonshoot.add_child(collision)
	area_commonshoot.add_child(bullet_sprite)
	area_commonshoot.set_collision_mask_value(3,true) # Enemies маска
	area_commonshoot.set_collision_mask_value(1, true) # level_objects маска
	area_commonshoot.z_index = 2
	inventory[indx].current_bullet -= 1

	get_tree().root.get_node("Level").add_child(area_commonshoot)
	get_tree().root.get_node("Level").bullets.append(area_commonshoot)
	area_commonshoot.position = get_tree().root.get_node("Level").get_node("player").position
	
#Вспомогательная функция для commonShoot
func deleteScene(stringNodePath): #Требуется для корректного удаления пули
	get_tree().root.get_node("Level").get_node(str(stringNodePath)).queue_free()
#Вспомогательные функции для lazerShoot
func fire(pos_x:float) -> void: #Произведение лазерного выстрела
		area_lazerGun.shape.b = Vector2(pos_x, 0)
		area_lazerGun.visible = true
		var isUp = -1
		$LazerGunLine.texture = load(inventory[currentWeaponIndex].bulletTexture)
		$LazerGunLine.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		if pos_x < 0:
			pos_x = pos_x * -1
		for i in range(pos_x/3):
			var point = Vector2(i * 5 * dirPlayer, isUp * (position.y/16))
			isUp = isUp * -1
			$LazerGunLine.add_point(point,i)
func check_tile(user_position_x: float, user_position_y: float, offset: int) -> bool: #Проверка на слой тайла
		var check_ground_layer = get_tree().root.get_node("Level").get_node("TileMap").get_cell_tile_data(2, Vector2i(
			(user_position_x + offset) / 16, user_position_y / 16))
		var check_trees_layer = get_tree().root.get_node("Level").get_node("TileMap").get_cell_tile_data(1, Vector2i(
			(user_position_x + offset) / 16, user_position_y / 16))
		return check_ground_layer != null or check_trees_layer != null
