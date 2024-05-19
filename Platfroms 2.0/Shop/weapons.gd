extends ItemList

var weapons = [] #Weapon
var selected_item_index: int = -1

func _on_ready():
	weapons = get_tree().root.get_node("main_menu").shop_weapons
	#Сортировка выбором
	for i in range(weapons.size()):
		var min_index = i
		for j in range(i+1, weapons.size()):
			if weapons[j].cost < weapons[min_index].cost:
				min_index = j
		var temp = weapons[i]
		weapons[i] = weapons[min_index]
		weapons[min_index] = temp
	
	for weapon in weapons:
		add_icon_item(load(weapon.icon))

func _on_item_selected(index):
	selected_item_index = index
	#var name_of_weapon = get_item_text(index)
	var icon_of_weapon = get_item_icon(index)
	var selected_weapon
	for w in weapons:
		if w.icon == icon_of_weapon.resource_path:
			selected_weapon = w
			break
			
	#$"../ScrollContainer/weapon_info/image"
	$"../image".texture = load(selected_weapon.icon)
	$"../rate".text	= ": " + 	str(selected_weapon.cost)
	$"../damage".text		= ": " + 		str(selected_weapon.damage)
	$"../bullet_speed".text	= ": " +str(selected_weapon.bullet_speed)
	$"../capacity".text		= ": " + 	str(selected_weapon.capacity)
	$"../cost".text = ": " + 	str(selected_weapon.fire_rate)
