using Godot;
using System;
using System.Collections.Generic;

public partial class Main : Control
{
	public Player player;
	public List<Weapon> weaponsInventory;
	public override void _Ready()
	{
		player = new Player();
		weaponsInventory = new List<Weapon>();
	}
}
