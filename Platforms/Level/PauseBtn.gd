extends TouchScreenButton

func btnPressed():
	get_tree().root.remove_child($"../..")
	
