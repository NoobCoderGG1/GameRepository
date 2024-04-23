using Godot;
using System;

public partial class Invertory : Button
{
	public override void _Ready()
	{
		Pressed += ButtonPressed;
	}

	new void ButtonPressed(){
		ReleaseFocus();
		Node inventory = ResourceLoader.Load<PackedScene>("res://Inventory.tscn").Instantiate();
		GetTree().Root.AddChild(inventory);
	}
	
}
