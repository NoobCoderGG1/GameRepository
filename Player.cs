using Godot;
using System;
using System.Collections.Generic;

public partial class Player : CharacterBody2D
{
	public int currentWeaponeIndex = -1;
	private float hp = 100.0f;
	public float Damage = 0f; //Не достал оружие.
	public float HP { get { return hp; } set { hp = value; } }
	public List<Vector2> helpVector = new List<Vector2>();

	public const float Speed = 300.0f;
	public const float JumpVelocity = -400.0f;

	public int countMoney = 0;
	public List<Weapon> inventory = new List<Weapon>();

	public float PosX;
	public float PosY;
	
	public List<Enemy1> enemies = new List<Enemy1>();

	public override void _Ready()
	{
		// Получается, что на каждой карте есть "реальный игрок", который бегает, стреляет
		// и есть "виртуальный игрок", который покупает и выбирает предметы
		// связь между ними реализована через вход "реального" в сцену
		// с копированием значения полей монеток и выбранных оружий
		/* Реальный_игрок.инвентарь = вирутальный_игрок.инвентарь */
		inventory = GetTree().Root.GetNode<Main>("Main").player.inventory;
		inventory.Add(new Weapon("Knife", 100, 50));
		// Name FireRate Damage BulletSpeed Status CurrentBullet Capacity
		countMoney = GetTree().Root.GetNode<Main>("Main").player.countMoney;
		PosX = GetNode<CollisionShape2D>("AreaPlayer/AreaCollision").Position.X;
		PosY = GetNode<CollisionShape2D>("AreaPlayer/AreaCollision").Position.Y;
	}	
	// Get the gravity from the project settings to be synced with RigidBody nodes.
	public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();

	public override void _PhysicsProcess(double delta)
	{
		GetNode<TextureProgressBar>("PlayerHealthBar").Value = hp;
		Vector2 velocity = Velocity;
		Vector2 v2 = new Vector2();

		if (!IsOnFloor())
			velocity.Y += gravity * (float)delta;

		if (Input.IsActionJustPressed("ui_accept") && IsOnFloor())
			velocity.Y = JumpVelocity;
		if (Input.IsActionJustPressed("move_down") && IsOnFloor())
			Position = new Vector2(Position.X, Position.Y + 5);
		
		if (Input.IsActionJustPressed("change_weapone") && inventory.Count>1)
		{
			switch (currentWeaponeIndex)
			{
				case -1:
				case 0:
					currentWeaponeIndex = 1;
					GD.Print(currentWeaponeIndex);
				break;
				case 1:
					currentWeaponeIndex = 2;
					GD.Print(currentWeaponeIndex);
					break;
				case 2:
					currentWeaponeIndex = 0;
					GD.Print(currentWeaponeIndex);
				break;
			}
			Damage = inventory[currentWeaponeIndex].Damage;
		}
		playerAttack(); //Проверка на атаку, а также выбор атаки в зависимости от оружия

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

	private void _on_shooting_body_entered(Node2D body)
	{
		if(body != null)
		{
			((Enemy1)body).HP-=24;
			GD.Print("Попадание");
		}
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

	private void playerAttack()
	{
		if (Input.IsActionJustPressed("attack")) {
			if (IsOnFloor() && currentWeaponeIndex == 2)
			{
				foreach (var enemy in enemies)
				{
					enemy.HP -= Damage;
				}
			}
			if (currentWeaponeIndex != -1)
			{
				if (inventory[currentWeaponeIndex].Name == "LazerGun")
				{
					var button = GetParent().GetNode<Button2>("Fire");
					button.PreButtonPressed();
				}
				else
				{
					var button = GetParent().GetNode<FireGun>("FireGun");
					button.ButtonPressed();
				}
			}
		}
	}
}
