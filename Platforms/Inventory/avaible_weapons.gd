extends ItemList

var selected_item_index: int #long
var weapons_inventory = [] # Weapon
#var virtual_player # Player

func _ready():
	#virtual_player = get_tree().root.get_node("main_menu").virtual_player
	weapons_inventory = get_tree().root.get_node("main_menu").weapon_inventory
	for weapon in weapons_inventory:
		var image = Image.load_from_file(weapon.icon)
		var texture = ImageTexture.create_from_image(image)
		add_icon_item(texture)

func _on_item_selected(index):
	selected_item_index = index
	
	var icon_of_weapon = get_item_icon(selected_item_index)
	var selected_weapon
	for w in weapons_inventory:
		var image = Image.load_from_file(w.icon)
		if ImageTexture.create_from_image(image).get_image().get_data() == icon_of_weapon.get_image().get_data():
			selected_weapon = w
			break
	
	$"../weapon_info/name".text			= "Name: " + 			selected_weapon.name
	$"../weapon_info/fire_rate".text	= "Fire rate: " + 	str(selected_weapon.fire_rate)
	$"../weapon_info/damage".text		= "Damage: " + 		str(selected_weapon.damage)
	$"../weapon_info/bullet_speed".text	= "Bullet_speed: " +str(selected_weapon.bullet_speed)
	$"../weapon_info/capacity".text		= "Capacity: " + 	str(selected_weapon.capacity)
	$"../weapon_info/description".text	= "Description: " + str(selected_weapon.description)
	
