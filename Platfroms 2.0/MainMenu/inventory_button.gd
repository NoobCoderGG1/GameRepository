extends Control



func _on_gui_input(event):
	if event.is_pressed():
		release_focus()
		var inventory: Node = ResourceLoader.load("res://Inventory/inventory.tscn").instance()
		get_tree().root.add_child(inventory)
