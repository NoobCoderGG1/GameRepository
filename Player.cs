using Godot;
using System;
using System.Collections.Generic;

public partial class Player : CharacterBody2D
{
	public string[] weapones = new string[] { "Arms", "Gun" }; //Пока нигде не используется
	static public int currentWeaponeIndex = 0;
	public float Damage = 5f;

	private float hp = 100.0f;
	public float HP { get { return hp; } set { hp = value; } }
	public List<Vector2> helpVector = new List<Vector2>();

	public const float Speed = 300.0f;
	public const float JumpVelocity = -400.0f;

	public int countMoney = 0;

	public float PosX;
	public float PosY;
	
	private List<Enemy1> enemies = new List<Enemy1>();

	public override void _Ready()
	{
		PosX = GetNode<CollisionShape2D>("AreaPlayer/AreaCollision").Position.X;
		PosY = GetNode<CollisionShape2D>("AreaPlayer/AreaCollision").Position.Y;
	}
	// Get the gravity from the project settings to be synced with RigidBody nodes.
	public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();

	public override void _PhysicsProcess(double delta)
	{
		if(hp <= 0) GD.Print("Убит"); 
		Vector2 velocity = Velocity;
		Vector2 v2 = new Vector2();

		// Add the gravity.
		if (!IsOnFloor())
			velocity.Y += gravity * (float)delta;


		// Handle Jump.
		if (Input.IsActionJustPressed("ui_accept") && IsOnFloor())
			velocity.Y = JumpVelocity;
		if (Input.IsActionJustPressed("move_down") && IsOnFloor())
			Position = new Vector2(Position.X, Position.Y + 5);
		if (Input.IsActionJustPressed("change_weapone"))
		{
			switch(currentWeaponeIndex) 
			{ 
				case 0: 
					currentWeaponeIndex = 1; 
					break;
				case 1:
					currentWeaponeIndex = 0;
					break;
			}
		}
		if (Input.IsActionJustPressed("melee_attack") && IsOnFloor() && currentWeaponeIndex == 0)
		{
			foreach (var enemy in enemies) { 
				enemy.HP -= Damage; 
				GD.Print(enemy.HP); 
			}
			GD.Print("Hit!");
			
		}

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		Vector2 direction = Input.GetVector("ui_left", "ui_right", "ui_up", "move_down");

		switch (direction)
		{
			case { X: 1, Y: _ }:
				velocity.X = direction.X * Speed;
				v2.Y = PosY;
				v2.X = PosX + 5;
				GetNode<CollisionShape2D>("AreaPlayer/AreaCollision").Position = v2;
				break;
			case { X: -1, Y:  _}:
				velocity.X = direction.X * Speed;
				v2.Y = PosY;
				v2.X = PosX - 5;
				GetNode<CollisionShape2D>("AreaPlayer/AreaCollision").Position = v2;
				break;
			case { X: 0, Y: _ }:
				velocity.X = Mathf.MoveToward(Velocity.X, 0, Speed);
				break;

		}
		Velocity = velocity;
		MoveAndSlide();
	}
	private void body_entered(Node2D body)
	{
		if (body.GetType() == typeof(Enemy1))
		{
			if (!enemies.Contains((Enemy1)body) && body != null)
				enemies.Add((Enemy1)body);
			GD.Print("A");
		}
	}
	private void body_exited(Node2D body)
	{
		if (body.GetType() == typeof(Enemy1))
		{
			if (enemies.Contains((Enemy1)body) && body != null)
				enemies.Remove((Enemy1)body);
			GD.Print("B");
		}
	}
	private void _on_shooting_body_entered(Node2D body)
	{
		if(body != null && currentWeaponeIndex == 1)
		{
			((Enemy1)body).HP-=24;
			GD.Print("Попадание");
		}
	}
}
