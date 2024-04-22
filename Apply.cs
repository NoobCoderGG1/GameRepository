using Godot;
using System;
using System.Linq;
using System.Collections.Generic;

public partial class Apply : Button
{
	ItemList itemList;
	long selectedIndex;
	Player player;
	Weapon selectedWeapon;
	List<Weapon> weapons;
	public override void _Ready()
	{
		Pressed+=ButtonPressed;
		itemList = GetTree().Root.GetNode<Control>("Shop").GetNode<ItemList>("ItemList");
		// Игрока нужно обязательно сделать как класс
		// иначе он просто будет недоступен вне уровня, как это показано снизу
		// player = GetTree().Root.GetNode<Node2D>("level").GetNode<Node2D>("Level").GetNode<Player>("Player");
		// Дальше, он просто не будет хранить в себе все изменения
		// магазина и инвентаря при переходе на следующие уровни
		// Следовательно, при загрузке каждого уровня необходимо перемещать игрока
		// на точку спавна (прописать ее так же, как и точки спавна противников)
		
		player = GetTree().Root.GetNode<Main>("Main").player;
		weapons = GetTree().Root.GetNode<Main>("Main").weaponsInventory;
	}

	new void ButtonPressed(){
		selectedIndex = itemList.selectedIndex;
		var nameOfWeapon = itemList.GetItemText((int)selectedIndex);
		selectedWeapon = itemList.weapons.Where(weapon => weapon.Name == nameOfWeapon).FirstOrDefault();
		if (selectedIndex!=-1){
			if (player.countMoney >= 0){ // Заменить на стоимость оружия
				player.countMoney -= 0;
				weapons.Add(selectedWeapon.Copy());
				selectedWeapon.Status = true;
			}
		}
	}
}
