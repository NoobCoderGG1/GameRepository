using Godot;
using System;

public partial class ItemList : Godot.ItemList
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		ItemSelected+=ItemSelectedHandler;
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
	public void ItemSelectedHandler(long index){
		GD.Print($"Выбран предмет по индексом {index}");
	}
}
