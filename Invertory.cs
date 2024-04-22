using Godot;
using System;

public partial class Invertory : Button
{
	public override void _Ready()
	{
		Pressed += ButtonPressed;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
	
	new void ButtonPressed(){
		ReleaseFocus();
		Node inventory = ResourceLoader.Load<PackedScene>("res://Inventory.tscn").Instantiate();
		GetTree().Root.AddChild(inventory);
	}
	
}
