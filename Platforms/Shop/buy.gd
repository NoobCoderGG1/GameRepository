extends Button

var shop_items # Weapon, витрина, node
var virtual_player # Player
var selected_index: int
var selected_weapon # Weapon
var weapon_inventory = [] # Weapon, инвентарь игрока

func _ready():
	shop_items = get_tree().root.get_node("shop").get_node("weapons")
	virtual_player = get_tree().root.get_node("main_menu").virtual_player
	weapon_inventory = get_tree().root.get_node("main_menu").weapon_inventory

func _on_gui_input(event):
	if event.is_pressed():
		release_focus()
		selected_index = shop_items.selected_item_index
		if selected_index != -1:
			var icon_of_weapon = shop_items.get_item_icon(selected_index)
			for w in shop_items.weapons:
				if load(w.icon).get_image().get_data() == icon_of_weapon.get_image().get_data():
					selected_weapon = w
					break
			if virtual_player.player_money >= selected_weapon.cost and selected_weapon.status == false:
				virtual_player.player_money -= selected_weapon.cost
				$"../user_money"._ready()
				selected_weapon.status = true
				weapon_inventory.append(selected_weapon.copy())
