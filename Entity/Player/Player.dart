library PLAYER;

import '../Entity.dart';
import '../../World/TileObject/TileObject.dart';
import 'PlayerType.dart';
import '../../Game.dart';
import '../Monster/Monster.dart';
import '../../Items/Item/Item.dart';
import '../../World/TileObject/TileType.dart';
import '../../Items/Item/ItemType.dart';
import '../../Items/Item/Chest.dart';
import '../../Items/Armor/Armor.dart';
import '../../Items/Weapon/Weapon.dart';
import '../../Items/Armor/ArmorType.dart';
import '../../Items/Weapon/WeaponType.dart';
import 'dart:math';

class Player extends Entity
{
  Player(Point point, PlayerType type) : super(point, type)
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
  
  void movePlayer(Point move)
  {
    int moveY = move.y;
    int moveX = move.x;

    if(moveX != 0 || moveY != 0)
    {
      enemyStats.style.opacity = "0";
      TileObject tileToMoveTo = world.getAtPoint(new Point(this.point.x + moveX, this.point.y + moveY));
      if(!(tileToMoveTo is Item))
      {
        if(!tileToMoveTo.isSolid)
        {
          moveTo(new Point(this.point.x + moveX, this.point.y + moveY));
        }
        else
        {
          addToNarration("You ran into a ${tileToMoveTo.type.NAME}", "black");
        }
      }
      else
      {
        touchedItem(world.getAtPoint(new Point(this.point.x + moveX, this.point.y + moveY)));
      }
      world.timeStep();
    }
    else
    {
      world.timeStep();
    }
  }
  
  void touchedItem(Item item)
  {
    if(item.type == ItemType.TREASURECHEST)
    {
      if(this.items.contains(ItemType.KEY))
      {
        this.items.remove(ItemType.KEY);
        Chest chest = item;
        world.setTileTypeAtPoint(chest.point, chest.treasureType);
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
        world.setTileTypeAtPoint(item.point, this.armor);
      }
      else
      {
        world.setTileTypeAtPoint(item.point, TileType.GROUND);
      }
      this.armor = item.type;
    }
    else if(item is Weapon)
    {
      if(this.weapon != WeaponType.NONE)
      {
        world.setTileTypeAtPoint(item.point, this.weapon);
      }
      else
      {
        world.setTileTypeAtPoint(item.point, TileType.GROUND);
      }
      this.weapon = item.type;
    }
    else if(item is Item)
    {
      this.items.add(item.type);
      world.setTileTypeAtPoint(item.point, TileType.GROUND);
    }
  }
  
  void addDeathToNarration(Monster monster)
  {
    addToNarration("You got killed by a ${monster.type.NAME}", "red");
  }
}