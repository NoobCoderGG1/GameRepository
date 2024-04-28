extends CharacterBody2D

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

func _ready():
	inventory = get_tree().root.get_node("main_menu").virtual_player.player_inventory
	var weapon_class = ResourceLoader.load("res://Weapon.gd")
	var tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.name = "Knife";	tmp_weapon.fire_rate = 100;	tmp_weapon.damage = 50.0;
	inventory.append(tmp_weapon)
	countMoney = get_tree().root.get_node("main_menu").virtual_player.player_money
	PosX = $AreaPlayer/AreaCollision.position.x
	PosY = $AreaPlayer/AreaCollision.position.y

func _physics_process(delta):
	$PlayerHealthBar.value = HP
	isMoving(delta)
	changeWeapon()
	player_attack()
	
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
	
func areaPlayer_entered(body):
	if not enemies.has(body) and body != null:
		enemies.append(body)
		print("В зоне!")
	
func areaPlayer_exited(body):
	if enemies.has(body) and body != null:
		enemies.erase(body)
		print("Bне зоны!")

func player_attack():
	if Input.is_action_just_pressed("attack"):
		if is_on_floor() and currentWeaponeIndex == -1:
			for enemy in enemies:
				enemy.HP -= damage
				print(enemy.HP)
			return
	if currentWeaponeIndex != -1:
		if inventory[currentWeaponeIndex].name == "LazerGun":
			#var button = get_parent().get_node("Fire") as Button2
			#button.pre_button_pressed()
			pass
		else:
			pass
			#var button = get_parent().get_node("FireGun") as FireGun
			#button.button_pressed()
