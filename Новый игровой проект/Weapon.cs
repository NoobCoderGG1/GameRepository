using Godot;
using System;

public partial class Weapon : Node
{
	public Weapon(string Name = "", long FireRate = 0, float Damage = 0f, float BulletSpeed = 0f, bool Status = false, int CurrentBullet = 0, int Capacity = 0){
		this.Name = Name;
		this.FireRate = FireRate;
		this.Damage = Damage;
		this.BulletSpeed = BulletSpeed;
		this.Status = Status;
		this.Capacity = Capacity;
		if (CurrentBullet == 0)
			this.CurrentBullet = Capacity;
		else
			this.CurrentBullet = CurrentBullet;
	}
	
	new public string Name {get; set;}
	public long FireRate {get; set;} // в миллисекундах
	public float Damage {get; set;}
	public float BulletSpeed {get; set;}
	public bool Status {get; set;}
	public int CurrentBullet {get; set;}
	public int Capacity {get; set;}
	
	public Weapon Copy(){
		return new Weapon(this.Name, this.FireRate, this.Damage, this.BulletSpeed, this.Status, this.CurrentBullet, this.Capacity);
	}
}
