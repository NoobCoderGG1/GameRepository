extends Button

var taken_weapons_list # Weapons
var selected_item_index: int # long
var virtual_player # Player

func _ready():
	taken_weapons_list = $"../taken_weapons"
	virtual_player = get_tree().root.get_node("main_menu").virtual_player

func is_in_taken(weapon):
	for w in virtual_player.player_inventory:
		if  w.icon == weapon.icon:
			return true
	return false

func _on_button_down():
		release_focus()
		selected_item_index = taken_weapons_list.selected_item_index
		var icon_of_weapon = taken_weapons_list.get_item_icon(selected_item_index)
		if icon_of_weapon == null:
			return
		var selected_weapon
		for w in virtual_player.player_inventory:
			if load(w.icon).get_image().get_data() == icon_of_weapon.get_image().get_data():
				selected_weapon = w
				break
		if selected_weapon == null:
			return
		if selected_item_index != -1 and is_in_taken(selected_weapon):
			virtual_player.player_inventory.remove_at(selected_item_index)
			$"../taken_weapons".update_list()
			virtual_player.weapon_count -= 1
