using Godot;
using System;
using System.Linq;
using System.Collections.Generic;

public partial class LevelLevel : Node2D
{
	public List<Area2D> bullets = new List<Area2D>();
	private Vector2[] spawn_positions = new Vector2[5] {new Vector2(x: 0,y: 0), new Vector2(x: 25, y: -79),
	new Vector2(x: 147, y: -6),new Vector2(x: 179,y: -50),new Vector2(x: 197,y: -6) };
	private PackedScene enemy_scene = (PackedScene)ResourceLoader.Load("res://enemy_1.tscn");
	private PackedScene coin_scene = (PackedScene)ResourceLoader.Load("res://coin.tscn");
	public static List<Enemy1> enemies = new List<Enemy1>(); //Список врагов на уровне
	
	private void spawn_timer()
	{
		Random random = new Random();
		int index_array = random.Next(0,5);
		Enemy1 enemy = (Enemy1)enemy_scene.Instantiate();
		enemy.Position = spawn_positions[index_array];
		switch (timerCount.min)
		{
			case 1:
				enemy.HP += 9;
				break;
		}
		AddChild(enemy);
		enemies.Add(enemy);
		GD.Print("Заспавнился");
	}
	
	public override void _PhysicsProcess(double delta){
		Player player = GetNode<Player>("Player");
		foreach (var bullet in bullets){
			CollisionShape2D cs = (CollisionShape2D)(bullet.GetChildren()[0]);
			SegmentShape2D ss = (SegmentShape2D)cs.Shape;
			ss.B = new Vector2( 
				(float)(ss.B.X 
				+ delta
				* player.inventory.Where(weap => weap.Name == ((string)bullet.Name).Split('~')[0]).FirstOrDefault().BulletSpeed), 
				ss.B.Y);
			ss.A = new Vector2(
				ss.B.X - 5,// Типо длина пули
				ss.B.Y
			);
			
		}
		
	}

}



