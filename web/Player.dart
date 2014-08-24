library PLAYER;

import 'Entity.dart';
import 'TileObject.dart';
import 'PlayerType.dart';
import 'Game.dart';
import 'Monster.dart';
import 'Item.dart';
import 'TileType.dart';
import 'ItemType.dart';
import 'Chest.dart';
import 'Armor.dart';
import 'Weapon.dart';
import 'ArmorType.dart';
import 'WeaponType.dart';

class Player extends Entity
{
  Player(int x, int y, PlayerType type) : super(x, y, type)
  {
    this.isWalkable = true;
    setAttributes();
    this.HP = this.MAXHP;
  }
  
  void setAttributes()
  {
    switch(this.type)
    {
      case PlayerType.GENERIC:
        this.MAXHP = 25;
        this.atk = 1;
        break;
      default:
        break;
    }
  }
  
  void getAttackedWithDmg(Monster monster)
  {
    monster.getAttackedWithDmg(this);
    if(monster.HP > 0)
    {
      int damage = takeDmg(monster);
      addToNarration("A ${monster.type.NAME} attacks you! (-$damage HP)", "red");
      if(this.HP > 0)
      {
        refreshStats(this);
      }
      else
      {
        refreshStats(this);// TODO died
        addDeathToNarration(monster);
      }
    }
  }
  
  void movePlayer(int x, int y)
  {
    int moveY = y;
    int moveX = x;

    if(moveX != 0 || moveY != 0)
    {
      enemyStats.style.opacity = "0";
      TileObject tileToMoveTo = world.grid.nodes[this.y + moveY][this.x + moveX];
      if(!(tileToMoveTo is Item))
      {
        if(!tileToMoveTo.isSolid)
        {
          moveTo(this.x + moveX, this.y + moveY);
        }
        else //TODO for debugging
        {
          print(tileToMoveTo.type.NAME); //TODO print touched item
        }
      }
      else
      {
        touchedItem(world.grid.nodes[this.y + moveY][this.x + moveX]);
      }
      world.timeStep();
    }
    else if(moveX == 0 && moveY == 0) //TODO timestep debugging, remove when finished
    {
      world.timeStep();
    }
  }
  
  void touchedItem(Item item) //TODO touchedItem()
  {
    print(item.type.NAME); //TODO print touched item
    if(item.type == ItemType.TREASURECHEST)
    {
      if(this.items.contains(ItemType.KEY))
      {
        this.items.remove(ItemType.KEY);
        Chest chest = item;
        world.setAtCoordinate(chest.x, chest.y, chest.treasureType);
        addToNarration("You used a key to open a chest (-1 key)", "green");
        if(!(chest.treasureType is ItemType) && !(chest.treasureType is ArmorType) && !(chest.treasureType is WeaponType))
        {
          addToNarration("The chest contains ${chest.treasureType.NAME}...", "red");
        }
      }
      else
      {
        addToNarration("You need a key to open this chest!", "black");
      }
    }
    else if(item is Item)
    {
      addToInventory(item);
      addToNarration("You picked up ${item.type.NAME}", "green");
    }
  }
  
  void addToInventory(Item item)
  {
    if(item is Armor)
    {
      if(this.armor != ArmorType.NONE)
      {
        world.setAtCoordinate(item.x, item.y, this.armor);
      }
      else
      {
        world.setAtCoordinate(item.x, item.y, TileType.GROUND);
      }
      this.armor = item.type;
    }
    else if(item is Weapon)
    {
      if(this.weapon != WeaponType.NONE)
      {
        world.setAtCoordinate(item.x, item.y, this.weapon);
      }
      else
      {
        world.setAtCoordinate(item.x, item.y, TileType.GROUND);
      }
      this.weapon = item.type;
    }
    else if(item is Item)
    {
      this.items.add(item.type);
      print(type.value);
      world.setAtCoordinate(item.x, item.y, TileType.GROUND);
    }
  }
  
  void addDeathToNarration(Monster monster)
  {
    addToNarration("You got killed by a ${monster.type.NAME}", "red");
  }
}