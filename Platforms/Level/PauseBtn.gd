extends TouchScreenButton

func btnPressed():
	var inventory = get_tree().root.get_node("main_menu").virtual_player.player_inventory
	get_tree().root.get_node("main_menu").virtual_player.player_money = $"../../player".countMoney
	
	get_tree().root.get_node("main_menu").get_node("play_button").visible = true
	get_tree().root.get_node("main_menu").get_node("shop_button").visible = true
	get_tree().root.get_node("main_menu").get_node("inventory_button").visible = true
	get_tree().root.get_node("main_menu").get_node("background").visible = true
	get_tree().root.remove_child($"../..")
	for w in inventory:
		if w.name == "Knife":
			inventory.erase(w)
			break
	
