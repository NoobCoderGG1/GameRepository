using Godot;
using System;


public partial class timerCount : Control
{
	float time_counter = 50.0F;
	public static int min, sec;
	bool attempt = false; //mutex

	public override void _PhysicsProcess(double delta)
	{
		time_counter += (float)delta;
		sec = (int)time_counter % 60;
		min = (int)((time_counter % 1000) / 60);

		string textTimer = string.Format($"{min:d2}:{sec:d2}");
		GetNode<Label>("Label").Text = textTimer;

		switch (min, sec, attempt) //Boost enemy
		{
			case (_, 1, true):
				attempt = false;
				break;
			case (1, 0, false):
				foreach(Enemy1 enemy in level.enemies)
				{
					enemy.Damage *= 2;
					enemy.HP += 9f;
					attempt = true;
				}
				break;
		}
	}
}
