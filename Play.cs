using Godot;
using System;

public partial class Play : Button
{
	// Called when the node enters the scene tree for the first time.
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
		Node level = ResourceLoader.Load<PackedScene>("res://level.tscn").Instantiate();
		GetTree().Root.AddChild(level);
	}
}
