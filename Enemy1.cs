using Godot;
using System;

public partial class Enemy1 : CharacterBody2D
{
	private PackedScene coin_scene = (PackedScene)ResourceLoader.Load("res://coin.tscn");

	public float Speed = 50f;
	public float Damage = 30f;
	public float HP = 1f;

	public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();
	public const float delay = 3f;
	public double lastHit = 0.0;

	public override void _PhysicsProcess(double delta)
	{
		if (HP <= 0) { 
			coin coin = (coin)coin_scene.Instantiate();
			coin.Position = new Vector2(x: Position.X, Position.Y);
			GetTree().Root.AddChild(coin);
			level.enemies.Remove(this);
			QueueFree();
			
		}
		GD.Print(HP);
		Vector2 velocity = Velocity;
		Vector2 target_velocity = new Vector2();

		if (Mathf.Abs(Position.X - GetParent().GetNode<CharacterBody2D>("Player").Position.X) > 25 ||
		Mathf.Abs(Position.Y - GetParent().GetNode<CharacterBody2D>("Player").Position.Y) > 25)
		{
			if (Position.X < GetParent().GetNode<CharacterBody2D>("Player").Position.X)
				velocity.X = 1;
			else
				if (Position.X > GetParent().GetNode<CharacterBody2D>("Player").Position.X)
				velocity.X = -1;
			target_velocity.X = velocity.X * Speed;
		}
		else
		{
		   //Attack bot
			if (lastHit <= 0)
			{
				GetParent().GetNode<Player>("Player").HP -= Damage;
				lastHit = delay;
			}
			else lastHit -= delta;
			
		}
		if (!IsOnFloor())
			target_velocity.Y += gravity * (float)delta;

		Velocity = target_velocity;
		MoveAndSlide();
	}
}
