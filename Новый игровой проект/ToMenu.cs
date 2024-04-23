using Godot;
using System;

public partial class ToMenu : Button
{
	public override void _Ready()
	{
		Pressed+=ButtonPressed;
	}
	
	new void ButtonPressed(){
		GetTree().Root.RemoveChild(GetTree().Root.GetNode<Control>("Inventory"));
	}
}
