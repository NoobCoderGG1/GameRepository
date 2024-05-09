extends ItemList

var virtual_player
var selected_item_index: int #long

func _ready():
	selected_item_index = -1
	virtual_player = get_tree().root.get_node("main_menu").virtual_player
	update_list()

func update_list():
	clear()
	for weapon in virtual_player.player_inventory:
		add_item(weapon.name)

func _on_item_selected(index):
	selected_item_index = index
	
	var name_of_weapon = get_item_text(index)
	var selected_weapon
	for w in virtual_player.player_inventory:
		if w.name == name_of_weapon:
			selected_weapon = w
			break
	$"../weapon_info/name".text			= "Name: " + 			selected_weapon.name
	$"../weapon_info/fire_rate".text	= "Fire rate: " + 	str(selected_weapon.fire_rate)
	$"../weapon_info/damage".text		= "Damage: " + 		str(selected_weapon.damage)
	$"../weapon_info/bullet_speed".text	= "Bullet_speed: " +str(selected_weapon.bullet_speed)
	$"../weapon_info/capacity".text		= "Capacity: " + 	str(selected_weapon.capacity)
	$"../weapon_info/description".text	= "Description: " + str(selected_weapon.description)
