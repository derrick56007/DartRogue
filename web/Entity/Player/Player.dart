library PLAYER;

import '../Entity.dart';
import '../../World/TileObject/TileObject.dart';
import 'PlayerType.dart';
import '../../Game/Game.dart';
import '../Monster/Monster.dart';
import '../../Items/Item/Item.dart';
import '../../World/TileObject/TileType.dart';
import '../../Items/Item/ItemType.dart';
import '../../Items/Item/Chest.dart';
import '../../Items/Armor/Armor.dart';
import '../../Items/Weapon/Weapon.dart';
import '../../Items/Armor/ArmorType.dart';
import '../../Items/Weapon/WeaponType.dart';
import '../Monster/MonsterType.dart';
import '../Monster/RangedMonster.dart';
import 'dart:math';
import '../../Game/Visual/Display.dart';

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
        this.MAXHP = 50;
        this.atk = 1;
        break;

      default:
        break;
    }
  }

  void getAttackedWithDmg(Monster monster, bool counter)
  {
    if(counter)
    {
      monster.getAttackedWithDmg(this);
    }
    if(monster.HP > 0)
    {
      int damage = takeDmg(monster);
      display.addToNarration("A ${monster.type.NAME} attacks you! (-$damage HP)", "red");
      checkIfDead(monster);
    }
  }

  void movePlayer(Point move)
  {
    if((move.x != 0 || move.y != 0) && (this.point.y + move.y < world.grid.nodes.length && this.point.x + move.x < world.grid.nodes[0].length))
    {
      enemyStats.style.opacity = "0";
      TileObject tileToMoveTo = world.getAtPoint(new Point(this.point.x + move.x, this.point.y + move.y));

      if(!(tileToMoveTo is Item))
      {
        if(!tileToMoveTo.isSolid)
        {
          moveTo(tileToMoveTo.point);
          if(tileToMoveTo.type == TileType.SPIKE)
          {
            display.addToNarration("You step on a spike", "red");
            checkIfDead(tileToMoveTo);
          }
        }
        else if(tileToMoveTo is RangedMonster)
        {
          RangedMonster rangedMonster = tileToMoveTo;
          rangedMonster.getAttackedWithDmg(this);
        }
        else
        {
          display.addToNarration("You run into a ${tileToMoveTo.type.NAME}", "black");
        }
      }
      else
      {
        touchedItem(world.getAtPoint(new Point(this.point.x + move.x, this.point.y + move.y)));
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
        display.addToNarration("You use a key to open a chest (-1 key)", "green");
        if(chest.treasureType is MonsterType)
        {
          display.addToNarration("The chest contains a ${chest.treasureType.NAME}...", "red");
        }
      }
      else
      {
        display.addToNarration("You need a key to open this chest!", "black");
      }
    }
    else if(item is Item)
    {
      addToInventory(item);
      display.addToNarration("You pick up ${item.type.NAME}", "green");
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

  void checkIfDead(TileObject tile)
  {
    display.refreshStats(this);
    if(this.HP <= 0)
    {
      addDeathToNarration(tile);
    }
  }

  void addDeathToNarration(TileObject tile)
  {
    display.addToNarration("A ${tile.type.NAME} kills you", "red");
  }
}