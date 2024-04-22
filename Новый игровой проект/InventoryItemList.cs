using Godot;
using System;
using System.Collections.Generic;

public partial class InventoryItemList : ItemList
{
	public Player player;
	public long selectedIndex;
	public List<Weapon> weaponsInventory;
	public override void _Ready()
	{
		ItemSelected+=ItemSelectedHandler;
		player = GetTree().Root.GetNode<Main>("Main").player;
		weaponsInventory = GetTree().Root.GetNode<Main>("Main").weaponsInventory;
		for (int i = 0; i < weaponsInventory.Count; i++){
			AddItem(weaponsInventory[i].Name);
		}
	}
	
	public void ItemSelectedHandler(long index){
		selectedIndex = index;
	}
}
