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
      takeDmg(monster);
      addToNarration("A ${monster.type.NAME} attacks you! (${monster.atk} dmg)", "red");
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
      if(!(world.grid.nodes[this.tileObject.y + moveY][this.tileObject.x + moveX] is Item))
      {
        if(!world.grid.nodes[this.tileObject.y + moveY][this.tileObject.x + moveX].isSolid)
        {
          moveTo(this.x + moveX, this.y + moveY);
        }
      }
      else
      {
        touchedTile(world.grid.nodes[this.y + moveY][this.x + moveX]);
      }
      world.timeStep();
    }
    else if(moveX == 0 && moveY == 0) //TODO timestep debugging, remove when finished
    {
      world.timeStep();
    }
  }
  
  void touchedTile(TileObject tileObject) //TODO touchedTile()
  {
    print(tileObject.type.NAME); //TODO print touched tile
    
    if(tileObject.type == ItemType.TREASURECHEST)
    {
      Chest chest = tileObject;
      world.grid.nodes[chest.y][chest.x] = chest.treasure;
      addToNarration("You opened a chest", "green");
    }
    else if(tileObject is Item)
    {
      addToInventory(tileObject);
      addToNarration("You picked up a ${tileObject.type.NAME}", "green");
    }
  }
  
  void addToInventory(TileObject tileObject)
  {
    if(tileObject is Armor)
    {
      if(this.armor != ArmorType.NONE)
      {
        print("not empty");
        world.setAtCoordinate(tileObject.x, tileObject.y, this.armor);
      }
      else
      {
        world.setAtCoordinate(tileObject.x, tileObject.y, TileType.GROUND);
      }
      this.armor = tileObject.type;
    }
    else if(tileObject is Weapon)
    {
      if(this.weapon != WeaponType.NONE)
      {
        world.setAtCoordinate(tileObject.x, tileObject.y, this.weapon);
      }
      else
      {
        world.setAtCoordinate(tileObject.x, tileObject.y, TileType.GROUND);
      }
      this.weapon = tileObject.type;
    }
    else if(tileObject is Item)
    {
      this.items.add(type);
      world.setAtCoordinate(tileObject.x, tileObject.y, TileType.GROUND);
    }
  }
  
  void addDeathToNarration(Monster monster)
  {
    addToNarration("You got killed by a ${monster.type.NAME}", "red");
  }
}