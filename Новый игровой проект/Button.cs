using Godot;
using System;

public partial class Button : Godot.Button
{
	public override void _Ready()
	{
		Pressed += ButtonPressed;
	}

	new void ButtonPressed(){
		ReleaseFocus();
		Node main = ResourceLoader.Load<PackedScene>("res://Main.tscn").Instantiate();
		GetTree().Root.AddChild(main);
		GetTree().Root.RemoveChild(GetParent());
	}
}
