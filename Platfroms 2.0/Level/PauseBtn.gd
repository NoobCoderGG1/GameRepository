extends TouchScreenButton



func PauseBtn_pressed():
	var inventory = get_tree().root.get_node("main_menu").virtual_player.player_inventory
	get_tree().root.get_node("main_menu").virtual_player.player_money = get_tree().root.get_node("main_menu").virtual_player.player_money + ($"../../player".countMoney * $"../timerCount".min) 
	$"../timerCount".time_counter = 0.0
	for w in inventory:
		if w.name == "Knife":
			inventory.erase(w)
			break
	get_tree().root.get_node("main_menu").get_node("play_button").visible = true
	get_tree().root.get_node("main_menu").get_node("shop_button").visible = true
	get_tree().root.get_node("main_menu").get_node("inventory_button").visible = true
	get_tree().root.get_node("main_menu").get_node("background").visible = true
	get_tree().root.remove_child($"../..")
