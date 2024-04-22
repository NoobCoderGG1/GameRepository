using Godot;
using System;
using System.Collections.Generic;

public partial class Button2 : Button
{
	CollisionShape2D area;
	CollisionShape2D helpArea;
	CharacterBody2D player;
	DateTime time = DateTime.Now;
	public float offset;
	public override void _Ready()
	{
		player = GetTree().Root.GetNode<Node2D>("Level").GetNode<CharacterBody2D>("Player");
		Pressed += PreButtonPressed;
		area = player.GetNode<Area2D>("Shooting").GetNode<CollisionShape2D>("CollisionShape2D");
		area.Visible=false;
		
		helpArea = player.GetNode<Area2D>("HelpShooting").GetNode<CollisionShape2D>("CollisionShape2D");
		helpArea.Visible=false;
	}
	
	public override void _Process(double delta)
	{
		if (DateTime.Now-time >= new TimeSpan(0, 0, 0, 0, 200))
			{
			area.Visible = false;
			((SegmentShape2D)area.Shape).B = new Vector2(0, 0);
			((SegmentShape2D)helpArea.Shape).B = new Vector2(0, 0);
			time = DateTime.Now;
		}
	}
	
	void PreButtonPressed(){
		ReleaseFocus();
		
		for (int i = 0; i<20*16; i+=16){
			((SegmentShape2D)helpArea.Shape).B = new Vector2(i, 0);
			if (ChkTile(((Player)player).Position.X, ((Player)player).Position.Y, i)) {
				FireFire(i - ((Player)player).Position.X % 16 + 8);
				break;
			}
		}
	}
	
	public void FireFire(float PosX){
		((SegmentShape2D)area.Shape).B = new Vector2(PosX, 0);
		area.Visible = true;
	} 
	
	private bool ChkTile(float userPositionX, float userPositionY, int offset){
		var chk = GetTree().Root.GetNode<Node>("Level").GetNode<TileMap>("TileMap").GetCellTileData(2, new Vector2I( (int) ((userPositionX+offset)/16), (int) (userPositionY/16) ) );		
		if (chk!=null) return true;
		return false;
	}
}
