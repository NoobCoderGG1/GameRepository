extends ItemList

var selected_item_index: int #long
var weapons_inventory = [] # Weapon
#var virtual_player # Player

func _ready():
	#virtual_player = get_tree().root.get_node("main_menu").virtual_player
	weapons_inventory = get_tree().root.get_node("main_menu").weapon_inventory
	for i in range(weapons_inventory.size()):
		var min_index = i
		for j in range(i+1, weapons_inventory.size()):
			if weapons_inventory[j].cost < weapons_inventory[min_index].cost:
				min_index = j
		var temp = weapons_inventory[i]
		weapons_inventory[i] = weapons_inventory[min_index]
		weapons_inventory[min_index] = temp
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
	$"../weapon_info/fire_rate".text	= ": " + 	str(selected_weapon.fire_rate)
	$"../weapon_info/damage".text		= ": " + 		str(selected_weapon.damage)
	$"../weapon_info/bullet_speed".text	= ": " +str(selected_weapon.bullet_speed)
	$"../weapon_info/capacity".text		= ": " + 	str(selected_weapon.capacity)
