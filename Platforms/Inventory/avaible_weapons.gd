extends ItemList

var selected_item_index: int #long
var weapons_inventory = [] # Weapon
#var virtual_player # Player

func _ready():
	#virtual_player = get_tree().root.get_node("main_menu").virtual_player
	weapons_inventory = get_tree().root.get_node("main_menu").weapon_inventory
	for weapon in weapons_inventory:
		add_icon_item(load(weapon.icon))

func _on_item_selected(index):
	selected_item_index = index
	
	var icon_of_weapon = get_item_icon(selected_item_index)
	var selected_weapon
	for w in weapons_inventory:
		if load(w.icon).get_image().get_data() == icon_of_weapon.get_image().get_data():
			selected_weapon = w
			break
	
	
	$"../weapon_info/image".texture = load(selected_weapon.icon)
	$"../weapon_info/fire_rate".text	= "Fire rate: " + 	str(selected_weapon.fire_rate)
	$"../weapon_info/damage".text		= "Damage: " + 		str(selected_weapon.damage)
	$"../weapon_info/bullet_speed".text	= "Bullet_speed: " +str(selected_weapon.bullet_speed)
	$"../weapon_info/capacity".text		= "Capacity: " + 	str(selected_weapon.capacity)
	
	
