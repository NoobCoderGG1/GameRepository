using Godot;
using System;

public partial class TakenItem : ItemList
{
	
	public Player player;
	new public long selectedIndex;
	public override void _Ready()
	{
		ItemSelected+=ItemSelectedHandler;
		player = GetTree().Root.GetNode<Main>("Main").player;
		UpdateList();
	}
	
	public void ItemSelectedHandler(long index){
		selectedIndex = index;
	}
	
	public void UpdateList(){
		Clear();
		for (int i = 0; i < player.inventory.Count; i++){
			AddItem(player.inventory[i].Name);
		}
	}
}
