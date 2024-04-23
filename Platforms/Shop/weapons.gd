extends ItemList

var weapons = [] #Weapon
var selected_item_index: int = -1

func _on_ready():
	weapons = get_tree().root.get_node("main_menu").shop_weapons
	for weapon in weapons:
		add_item(weapon.name)

func _on_item_selected(index):
	selected_item_index = index
	
	var name_of_weapon = get_item_text(index)
	var selected_weapon
	for w in weapons:
		if w.name == name_of_weapon:
			selected_weapon = w
			break
	
	$"../weapon_info/name".text			= "Name: " + 			selected_weapon.name
	$"../weapon_info/fire_rate".text	= "Fire rate: " + 	str(selected_weapon.fire_rate)
	$"../weapon_info/damage".text		= "Damage: " + 		str(selected_weapon.damage)
	$"../weapon_info/bullet_speed".text	= "Bullet_speed: " +str(selected_weapon.bullet_speed)
	$"../weapon_info/capacity".text		= "Capacity: " + 	str(selected_weapon.capacity)
	$"../weapon_info/description".text	= "Description: " + str(selected_weapon.description)
