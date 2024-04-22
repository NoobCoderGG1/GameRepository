using Godot;
using System;

public partial class Play : Button
{
	public override void _Ready()
	{
		Pressed += ButtonPressed;
	}
	
	new void ButtonPressed(){
		ReleaseFocus();
		Node level = ResourceLoader.Load<PackedScene>("res://level.tscn").Instantiate();
		GetTree().Root.AddChild(level);
	}
}
