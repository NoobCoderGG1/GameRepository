using Godot;
using System;

public partial class Shop : Button
{
	public override void _Ready()
	{
		Pressed += ButtonPressed;
	}

	new void ButtonPressed(){
		ReleaseFocus();
		Node shop = ResourceLoader.Load<PackedScene>("res://Shop.tscn").Instantiate();
		GetTree().Root.AddChild(shop);
	}
}
