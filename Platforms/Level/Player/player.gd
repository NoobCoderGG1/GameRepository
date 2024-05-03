extends CharacterBody2D

#Переменные игрока
@onready var player = $"."
var currentWeaponIndex = -1
var HP = 100
var damage: int = 0 #Не достал оружие.
var helpVector = [] #Vector2 
var SPEED: float = 300.0
var JUMP_VELOCITY: float = -400.0
var countMoney:int = 0;
var inventory = [] #Weapones
#Координаты смещения зоны "радиуса атаки ближнего боя" от самого героя
var PosX:float; 
var PosY:float;
var enemies = []
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Переменные необходимые для lazerGun стрельбы
var area_lazerGun : CollisionShape2D
var helpArea : CollisionShape2D
@onready var timerNode = $"../UI/timerCount"
var timeNow
var offset : float
#Переменные необходимые для commonShoot стрельбы
var virtual_player_commonShoot
var realPlayer
var dt #как timeNow, но для commonShoot
var area_commonshoot
var animated_player_sprite

func _ready():
	animated_player_sprite = $playerSprite
	inventory = get_tree().root.get_node("main_menu").virtual_player.player_inventory
	var weapon_class = ResourceLoader.load("res://Weapon.gd")
	var tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.name = "Knife";	tmp_weapon.fire_rate = 100;	tmp_weapon.damage = 50.0;
	inventory.append(tmp_weapon)
	countMoney = get_tree().root.get_node("main_menu").virtual_player.player_money
	PosX = $AreaPlayer/AreaCollision.position.x
	PosY = $AreaPlayer/AreaCollision.position.y
	#Инициализация переменных для lazerGun стрельбы
	area_lazerGun = player.get_node("Shooting").get_node("CollisionShape2D")
	area_lazerGun.visible = false
	helpArea = player.get_node("HelpShooting").get_node("CollisionShape2D")
	helpArea.visible = false
	timeNow = timerNode.time_counter
	#Инициализация переменных для commonShoot стрельбы
	virtual_player_commonShoot = get_tree().root.get_node("main_menu").virtual_player
	realPlayer = get_tree().root.get_node("Level").get_node("player")
	dt = timerNode.time_counter

func _physics_process(delta):
	$PlayerHealthBar.value = HP
	#Вынес все условия и прочие действия в функции
	isMoving(delta)
	changeWeapon()
	player_attack()
	#Для LazerGun, чтобы луч пропадал через время
	if timerNode.time_counter - timeNow >= 0.2:
		area_lazerGun.visible = false
		area_lazerGun.shape.b = Vector2(0, 0)
		helpArea.shape.b = Vector2(0, 0)
		timeNow = timerNode.time_counter
	
func isMoving(delta):
	var Velocity : Vector2 = velocity
	var dirAreaPlayer : Vector2 = Vector2() #Направление взгляда героя
	# Add the gravity.
	if not is_on_floor():
		Velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		Velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("move_down") and is_on_floor():
		position = Vector2(position.x, position.y + 5);
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("move_left","move_right","jump","move_down")
	if direction.x == 1 or direction.x == -1:
			animated_player_sprite.animation = "player_walk"
			animated_player_sprite.play()
			animated_player_sprite.flip_h = direction.x < 0
			Velocity.x = direction.x * SPEED;
			dirAreaPlayer.y = PosY;
			dirAreaPlayer.x = PosX + 5 * direction.x; #Перемещение "взгляда" персонажа
			$AreaPlayer/AreaCollision.position = dirAreaPlayer;
	if direction == Vector2.ZERO:
			Velocity.x = move_toward(velocity.x, 0, SPEED);
		
	velocity = Velocity;
	move_and_slide();

func changeWeapon():
	if Input.is_action_just_pressed("change_weapon") and inventory.size() > 1:
		match currentWeaponIndex:
			-1, 0:
				currentWeaponIndex = 1
			1:
				if inventory.size() < 3:
					currentWeaponIndex = 0
				else:
					currentWeaponIndex = 2
			2:
				currentWeaponIndex = 0
		damage = inventory[currentWeaponIndex].damage
	
func player_attack():
	if Input.is_action_just_pressed("attack"):
		if is_on_floor() and currentWeaponIndex == -1: #Урон по области, если в руках оружие ближнего боя
			for enemy in enemies:
				enemy.HP -= damage
				print(enemy.HP)
			return
		if currentWeaponIndex != -1:
			if inventory[currentWeaponIndex].name == "LazerGun":
				lazerShoot()
			else:
				commonShoot()

func areaPlayer_entered(body): #Заносит врагов в список, если они попали в область действия оружия ближнего боя
	if not enemies.has(body) and body != null:
		enemies.append(body)
func areaPlayer_exited(body): #Выносит из списка
	if enemies.has(body) and body != null:
		enemies.erase(body)

func shootingBody_entered(body): #Функция для lazerShoot
	if body != null:
		body.HP -= 24
#Функции осуществляющие стрельбу
func lazerShoot():
	for i in range(0, 20*16, 16):
		helpArea.shape.b = Vector2(i, 0)
		if check_tile(player.position.x, player.position.y, i): #Проверка на tile
			fire(float(i - fmod(player.position.x, 16.0) + 0)) 
			return
	fire(400)
	
func commonShoot():
	var indx = get_tree().root.get_node("Level").get_node("player").currentWeaponIndex
	var weapon = inventory[indx] #Получение текущего оружия игрока
	var fr = weapon.fire_rate
	if timerNode.time_counter - dt < fr / 1000.0: #TimeSpan(0, 0, int(fr / 60000), int(fr / 1000), int(fr % 1000); Для регулировки скорости атаки
		return
	if indx == -1:
		return
	if inventory[indx].current_bullet == 0:
		print("Перезарядка")
		inventory[indx].current_bullet = inventory[indx].capacity
		return
	dt = timerNode.time_counter
	#Создание коллизии пули
	var segment := SegmentShape2D.new()
	segment.a = Vector2(0,0)
	segment.b = Vector2(5,0)
	var collision := CollisionShape2D.new()
	collision.debug_color = Color(255, 0, 0, 1)
	collision.shape = segment
	#Создание узла спрайта для пули
	var bullet_sprite := Sprite2D.new()
	bullet_sprite.texture = load("res://UI/assets/Weapons/gold_bullet.png")
	bullet_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	bullet_sprite.scale = Vector2(0.35,0.35)
	#Создание пули и ее размещение в узле "Level"
	area_commonshoot = Area2D.new()
	area_commonshoot.name = inventory[indx].name + "~" + str(inventory[indx].current_bullet)
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
	area_commonshoot.name = inventory[indx].name + "~" + str(inventory[indx].current_bullet)
	inventory[indx].current_bullet -= 1

	get_tree().root.get_node("Level").add_child(area_commonshoot)
	get_tree().root.get_node("Level").bullets.append(area_commonshoot)
	area_commonshoot.position = get_tree().root.get_node("Level").get_node("player").position
	
#Вспомогательная функция для commonShoot
func deleteScene(stringNodePath): #Требуется для корректного удаления 
	get_tree().root.get_node("Level").get_node(str(stringNodePath)).queue_free()
#Вспомогательные функции для lazerShoot
func fire(pos_x:float) -> void: #Произведение лазерного выстрела
		area_lazerGun.shape.b = Vector2(pos_x, 0)
		area_lazerGun.visible = true
func check_tile(user_position_x: float, user_position_y: float, offset: int) -> bool: #Проверка на слой тайла
		var check_ground_layer = get_tree().root.get_node("Level").get_node("TileMap").get_cell_tile_data(2, Vector2i(
			(user_position_x + offset) / 16, user_position_y / 16))
		var check_trees_layer = get_tree().root.get_node("Level").get_node("TileMap").get_cell_tile_data(1, Vector2i(
			(user_position_x + offset) / 16, user_position_y / 16))
		return check_ground_layer != null or check_trees_layer != null

