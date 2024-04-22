using Godot;
using System;

public partial class FireGun : Button
{
	Player player;
	DateTime dt;
	Weapon weapon;
	
	public override void _Ready()
	{
		Pressed += ButtonPressed;
		player = GetTree().Root.GetNode<Main>("Main").player;
		dt = DateTime.Now;
	}
	
	public new void ButtonPressed(){
		ReleaseFocus();
		int indx = GetTree().Root.GetNode<LevelLevel>("Level").GetNode<Player>("Player").currentWeaponeIndex;
		weapon = player.inventory[indx];
		int fr = (int)weapon.FireRate;
		if (DateTime.Now - dt < (new TimeSpan(0, 0, (int) fr / 60000,(int) fr / 1000,(int) fr % 1000))) return;
		if (indx == -1) return;
		if (player.inventory[indx].CurrentBullet==0){
			GD.Print("Перезарядка");
			player.inventory[indx].CurrentBullet = player.inventory[indx].Capacity;
			return;
		}
		dt = DateTime.Now;
		SegmentShape2D segment = new SegmentShape2D();
		segment.A = new Vector2(player.Position.X,player.Position.Y);
		segment.B = new Vector2(player.Position.X,player.Position.Y);
		CollisionShape2D collision = new CollisionShape2D();
		collision.DebugColor = new Color(255, 0, 0, 1);
		collision.Shape = segment;
		Area2D area = new Area2D();
		area.BodyEntered += (Node2D body) => {
			if (body is Enemy1 || body is Godot.TileMap){
				if (body is Enemy1){
					((Enemy1)body).HP-=player.Damage;
				}
				else if (body is Godot.TileMap){
				}
				GetTree().Root.GetNode<LevelLevel>("Level").GetNode<Area2D>($"{area.Name}").QueueFree();
				GetTree().Root.GetNode<LevelLevel>("Level").bullets.Remove(area);
			};
		};
		area.AddChild(collision);
		area.SetCollisionMaskValue(3, true); // Деревья
		area.SetCollisionMaskValue(6, true); // Враги
		area.ZIndex = 2;
		// Название ствола и его номер патрона
		// "AKM~29"
		area.Name = $"{player.inventory[indx].Name}~{player.inventory[indx].CurrentBullet}";
		player.inventory[indx].CurrentBullet-=1;
		GetTree().Root.GetNode<LevelLevel>("Level").AddChild(area);
		GetTree().Root.GetNode<LevelLevel>("Level").bullets.Add(area);

		area.Position = GetTree().Root.GetNode<LevelLevel>("Level").GetNode<Player>("Player").Position;
	}
}
