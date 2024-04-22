using Godot;
using System;
using System.Linq;
using System.Collections.Generic;

public partial class InventaryApply : Button
{
	InventoryItemList itemList;
	long selectedIndex;
	Player player;
	public override void _Ready()
	{
		Pressed+=ButtonPressed;
		itemList = GetParent().GetNode<InventoryItemList>("InventoryItemList");
		player = GetTree().Root.GetNode<Main>("Main").player;
	}

	new void ButtonPressed(){
		selectedIndex = itemList.selectedIndex;
		var nameOfWeapon = itemList.GetItemText((int)selectedIndex);
		var selectedWeapon = itemList.weapons.Where(weapon=>weapon.Name == nameOfWeapon).FirstOrDefault();
		if (selectedIndex!=-1){
			player.inventory.Add(selectedWeapon.Copy());
			GetParent().GetNode<TakenItem>("ItemList").UpdateList();
		}
	}
}
