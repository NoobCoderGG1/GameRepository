extends CharacterBody2D

#Переменные игрока
@onready var player = $"."
var currentWeaponeIndex = -1
var HP = 100
var damage: int = 0 #Не достал оружие.
var helpVector = [] #Vector2 
var SPEED: float = 300.0
var JUMP_VELOCITY: float = -400.0
var countMoney:int = 0;
var inventory = [] #Weapones
var PosX:float;
var PosY:float;
var enemies = [] #Enemy
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#Переменные необходимые для lazerGun стрельбы
var area : CollisionShape2D
var helpArea : CollisionShape2D
@onready var timerNode = $"../UI/timerCount"
var timeNow
var offset : float
#Переменные необходимые для commonShoot стрельбы
var vplayer_commonShoot
var realPlayer
var dt #как timeNow, но для commonShoot
var area_commonshoot

func _ready():
	inventory = get_tree().root.get_node("main_menu").virtual_player.player_inventory
	var weapon_class = ResourceLoader.load("res://Weapon.gd")
	var tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.name = "Knife";	tmp_weapon.fire_rate = 100;	tmp_weapon.damage = 50.0;
	inventory.append(tmp_weapon)
	countMoney = get_tree().root.get_node("main_menu").virtual_player.player_money
	PosX = $AreaPlayer/AreaCollision.position.x
	PosY = $AreaPlayer/AreaCollision.position.y
	#Инициализация переменных для lazerGun стрельбы
	area = player.get_node("Shooting").get_node("CollisionShape2D")
	area.visible = false
	helpArea = player.get_node("HelpShooting").get_node("CollisionShape2D")
	helpArea.visible = false
	timeNow = timerNode.time_counter
	#Инициализация переменных для commonShoot стрельбы
	vplayer_commonShoot = get_tree().root.get_node("main_menu").virtual_player
	realPlayer = get_tree().root.get_node("Level").get_node("player")
	dt = timerNode.time_counter

func _physics_process(delta):
	$PlayerHealthBar.value = HP
	#Вынес все условия и прочие действия в функции
	isMoving(delta)
	changeWeapon()
	player_attack()
	#Для LazerGun, чтобы луч пропадал
	if timerNode.time_counter - timeNow >= 0.2:
		area.visible = false
		area.shape.b = Vector2(0, 0)
		helpArea.shape.b = Vector2(0, 0)
		timeNow = timerNode.time_counter
	
func isMoving(delta):
	var Velocity : Vector2 = velocity
	var dirAreaPlayer : Vector2 = Vector2()
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
			Velocity.x = direction.x * SPEED;
			dirAreaPlayer.y = PosY;
			dirAreaPlayer.x = PosX + 5 * direction.x;
			$AreaPlayer/AreaCollision.position = dirAreaPlayer;
	if direction == Vector2.ZERO:
			Velocity.x = move_toward(velocity.x, 0, SPEED);
		
	velocity = Velocity;
	move_and_slide();

func changeWeapon():
	if Input.is_action_just_pressed("change_weapon") and inventory.size() > 1:
		match currentWeaponeIndex:
			-1, 0:
				currentWeaponeIndex = 1
			1:
				currentWeaponeIndex = 2
			2:
				currentWeaponeIndex = 0
		damage = inventory[currentWeaponeIndex].damage
	
func player_attack():
	if Input.is_action_just_pressed("attack"):
		if is_on_floor() and currentWeaponeIndex == -1:
			for enemy in enemies:
				enemy.HP -= damage
				print(enemy.HP)
			return
		if currentWeaponeIndex != -1:
			if inventory[currentWeaponeIndex].name == "LazerGun":
				lazerShoot()
			else:
				commonShoot()

func areaPlayer_entered(body):
	if not enemies.has(body) and body != null:
		enemies.append(body)
		print("В зоне!")
		
func areaPlayer_exited(body):
	if enemies.has(body) and body != null:
		enemies.erase(body)
		print("Bне зоны!")

func shootingBody_entered(body):
	if body != null:
		body.HP -= 24
		print("Попадание!")
#Функции осуществляющие стрельбу
func lazerShoot():
	for i in range(0, 20*16, 16):
		helpArea.shape.b = Vector2(i, 0)
		if check_tile(player.position.x, player.position.y, i):
			fire(float(i - fmod(player.position.x, 16.0) + 0)) 
			return
	fire(400)
	
func commonShoot():
	var indx = get_tree().root.get_node("Level").get_node("player").currentWeaponeIndex
	var weapon = vplayer_commonShoot.player_inventory[indx]
	var fr = weapon.fire_rate
	if timerNode.time_counter - dt < fr / 1000.0: #TimeSpan(0, 0, int(fr / 60000), int(fr / 1000), int(fr % 1000)
		return
	if indx == -1:
		return
	if vplayer_commonShoot.player_inventory[indx].current_bullet == 0:
		print("Перезарядка")
		vplayer_commonShoot.player_inventory[indx].current_bullet = vplayer_commonShoot.player_inventory[indx].capacity
		return
	dt = timerNode.time_counter
	var segment := SegmentShape2D.new()
	#segment.a = Vector2(realPlayer.position.x, realPlayer.position.y)
	#segment.b = Vector2(realPlayer.position.x, realPlayer.position.y)
	segment.a = Vector2(0,0)
	segment.b = Vector2(5,0)
	var collision := CollisionShape2D.new()
	collision.debug_color = Color(255, 0, 0, 1)
	collision.shape = segment
	
	area_commonshoot = Area2D.new()
	area_commonshoot.name = vplayer_commonShoot.player_inventory[indx].name + "~" + str(vplayer_commonShoot.player_inventory[indx].current_bullet)
	var string_area_name = str(area_commonshoot.name)
	var area_copy = area_commonshoot
	var lambda = func(body): 
		var index = get_tree().root.get_node("Level").get_node("player").currentWeaponeIndex
		if body is CharacterBody2D or body is TileMap:
			if body is CharacterBody2D:
				print("")
				print(body.HP)
				body.HP -= realPlayer.damage
				print(body.HP)
			elif body is TileMap:
				
				print("Delete scene")
				print(area_copy)
				print(string_area_name)
				var node = get_tree().root.get_node("Level").get_node(NodePath(string_area_name))
				get_tree().root.get_node("Level").bullets.erase(area_copy)
				deleteScene(string_area_name)#в get_node(vplayer_commonShoot.player_inventory[indx].name + "~" + str(vplayer_commonShoot.player_inventory[indx].current_bullet))
				print("Finish")
				
	area_commonshoot.body_entered.connect(lambda)
	area_commonshoot.add_child(collision)
	area_commonshoot.set_collision_mask_value(3,true) # Enemies
	area_commonshoot.set_collision_mask_value(1, true) # level_objects
	area_commonshoot.z_index = 2
	area_commonshoot.name = vplayer_commonShoot.player_inventory[indx].name + "~" + str(vplayer_commonShoot.player_inventory[indx].current_bullet)
	vplayer_commonShoot.player_inventory[indx].current_bullet -= 1

	get_tree().root.get_node("Level").add_child(area_commonshoot)
	get_tree().root.get_node("Level").bullets.append(area_commonshoot)
	area_commonshoot.position = get_tree().root.get_node("Level").get_node("player").position
	print("Выстрел")
	print(area_commonshoot)
#Вспомогательная функция для commonShoot
func _on_BodyEntered(body):
	var indx = get_tree().root.get_node("Level").get_node("player").currentWeaponeIndex
	if body is CharacterBody2D or body is TileMap:
		if body is CharacterBody2D:
			print("")
			print(body.HP)
			body.HP -= realPlayer.damage
			print(body.HP)
		elif body is TileMap:
			get_tree().root.get_node("Level").get_node(str(area_commonshoot.name)).queue_free() #в get_node(vplayer_commonShoot.player_inventory[indx].name + "~" + str(vplayer_commonShoot.player_inventory[indx].current_bullet))
			get_tree().root.get_node("Level").bullets.erase(area_commonshoot)
#Вспомогательные функции для lazerShoot
func fire(pos_x:float) -> void:
		area.shape.b = Vector2(pos_x, 0)
		area.visible = true
func check_tile(user_position_x: float, user_position_y: float, offset: int) -> bool:
		var check_ground_layer = get_tree().root.get_node("Level").get_node("TileMap").get_cell_tile_data(2, Vector2i(
			(user_position_x + offset) / 16, user_position_y / 16))
		var check_trees_layer = get_tree().root.get_node("Level").get_node("TileMap").get_cell_tile_data(1, Vector2i(
			(user_position_x + offset) / 16, user_position_y / 16))
		return check_ground_layer != null or check_trees_layer != null

func deleteScene(stringNodePath):
	get_tree().root.get_node("Level").get_node(str(stringNodePath)).queue_free()
