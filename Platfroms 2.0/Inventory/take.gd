extends Button

var avaible_weapons_list # Weapons
var selected_item_index: int # long
var virtual_player # Player

func _ready():
	avaible_weapons_list = $"../avaible_weapons"
	virtual_player = get_tree().root.get_node("main_menu").virtual_player

func is_in_taken(weapon):
	for w in virtual_player.player_inventory:
		if w.icon == weapon.icon:
			return true
	return false

func _on_gui_input(event):
	if event.is_pressed():
		release_focus()
		selected_item_index = avaible_weapons_list.selected_item_index
		#var name_of_weapon = avaible_weapons_list.get_item_text(selected_item_index)
		var icon_of_weapon = avaible_weapons_list.get_item_icon(selected_item_index)
		var selected_weapon
		for w in avaible_weapons_list.weapons_inventory:
			if load(w.icon).get_image().get_data() == icon_of_weapon.get_image().get_data():
				selected_weapon = w
				break
		if selected_weapon == null:
			return
		if selected_item_index != -1 and not is_in_taken(selected_weapon) and virtual_player.weapon_count < 3:
			virtual_player.player_inventory.append(selected_weapon.copy())
			$"../taken_weapons".update_list()
			virtual_player.weapon_count += 1
