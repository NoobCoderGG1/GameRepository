extends Control



func _on_gui_input(event):
	if event.is_pressed():
		release_focus()
		var shop: Node = ResourceLoader.load("res://Shop/Shop.tscn").instance()
		get_tree().root.add_child(shop)
