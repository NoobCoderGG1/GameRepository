extends ItemList

var weapons = [] #Weapon
var selected_item_index: int = -1

func _on_ready():
	weapons = get_tree().root.get_node("main_menu").shop_weapons
	for weapon in weapons:
		add_icon_item(load(weapon.icon))

func _on_item_selected(index):
	selected_item_index = index
	
	#var name_of_weapon = get_item_text(index)
	var icon_of_weapon = get_item_icon(index)
	var selected_weapon
	for w in weapons:
		var image = Image.load_from_file(w.icon)
		if load(w.icon).get_image().get_data() == icon_of_weapon.get_image().get_data():
			selected_weapon = w
			break

	$"../ScrollContainer/weapon_info/image".texture = load(selected_weapon.icon)
	$"../ScrollContainer/weapon_info/fire_rate".text	= "Cost: " + 	str(selected_weapon.cost)
	$"../ScrollContainer/weapon_info/damage".text		= "Damage: " + 		str(selected_weapon.damage)
	$"../ScrollContainer/weapon_info/bullet_speed".text	= "Bullet_speed: " +str(selected_weapon.bullet_speed)
	$"../ScrollContainer/weapon_info/capacity".text		= "Capacity: " + 	str(selected_weapon.capacity)
	
