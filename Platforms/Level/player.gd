extends CharacterBody2D

var player = $player
var currentWeaponeIndex = -1
var HP: float = 100.0
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
	PosX = get_node("AreaPlayer/AreaCollision").Position.X
	PosY =  get_node("AreaPlayer/AreaCollision").Position.Y

func _physics_process(delta):
	get_node("PlayerHealthBar").Value = HP
	var velocity : Vector2 = Vector2.ZERO
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_just_pressed("move_down") and is_on_floor():
		Pos = Vector2(Position.X, Position.Y + 5);
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
