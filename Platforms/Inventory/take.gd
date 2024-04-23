extends Button

var avaible_weapons_list # Weapons
var selected_item_index: int # long
var virtual_player # Player

func _ready():
	avaible_weapons_list = $"../avaible_weapons"
	virtual_player = get_tree().root.get_node("main_menu").virtual_player

func is_in_taken(weapon):
	for w in virtual_player.player_inventory:
		if w.name == weapon.name:
			return true
	return false

func _on_gui_input(event):
	if event.is_pressed():
		release_focus()
		selected_item_index = avaible_weapons_list.selected_item_index
		var name_of_weapon = avaible_weapons_list.get_item_text(selected_item_index)
		var selected_weapon
		for w in avaible_weapons_list.weapons_inventory:
			if w.name == name_of_weapon:
				selected_weapon = w
				break
		if selected_item_index != -1 and not is_in_taken(selected_weapon):
			virtual_player.player_inventory.append(selected_weapon.copy())
			$"../taken_weapons".update_list()
