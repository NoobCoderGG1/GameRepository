using Godot;
using System;
using System.Collections.Generic;

public partial class ItemList : Godot.ItemList
{
	public List<Weapon> weapons = new List<Weapon>() 
							  { new Weapon("AKM", 800, 31f, 8f, false, 0, 30),
								new Weapon("SCARL", 900, 29f, 9f, false, 0, 30),
								new Weapon("KAR98K", 1200, 63f, 12f, false, 0, 5)};
	public long selectedIndex;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		selectedIndex=-1;
		ItemSelected+=ItemSelectedHandler;
		for (int i = 0; i < weapons.Count; i++){
			AddItem(weapons[i].Name);
		}
	}

	public void ItemSelectedHandler(long index){
		selectedIndex = index;
	}
}
