using Godot;
using System;

public class csharp_lambda : Node
{
	LambdaFunc lambda;
	delegate void LambdaFunc(Node2D body);

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		lambda += (Node2D body) => {
			if (body is Enemy || body is Godot.TileMap) {
				if (body is Enemy){
					GD.Print();
					GD.Print(((Enemy)body).HP);
					((Enemy)body).HP-=realPlayer.Damage;
					GetTree().Root.GetNode<Level>("Level").GetNode<Area2D>($"{GetTree().Root.GetNode("level").GetNode("player").area_commonshoot.name}").QueueFree();
					GetTree().Root.GetNode<Level>("Level").bullets.Remove(GetTree().Root.GetNode("level").GetNode("player").area_commonshoot);
				}
				
				else if (body is Godot.TileMap){
					GetTree().Root.GetNode<Level>("Level").GetNode<Area2D>($"{GetTree().Root.GetNode("level").GetNode("player").area_commonshoot.name}").QueueFree();
					GetTree().Root.GetNode<Level>("Level").bullets.Remove(GetTree().Root.GetNode("level").GetNode("player").area_commonshoot);
				}
			}
		};
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
