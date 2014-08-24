library PLAYER;

import 'Entity.dart';
import 'TileObject.dart';
import 'PlayerType.dart';
import 'Game.dart';
import 'Monster.dart';
import 'Item.dart';
import 'TileType.dart';

class Player extends Entity
{
  Player(int x, int y, TileObject tileObject, var type) : super(x, y, tileObject, type)
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
      if(!world.grid.nodes[this.tileObject.y + moveY][this.tileObject.x + moveX].isSolid)
      {
        moveTo(this.x + moveX, this.y + moveY);
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
  
  void touchedTile(var tileObject) //TODO touchedTile()
  {
    print(tileObject.type.NAME); //TODO print touched tile
    
    if(tileObject is Item)
    {
      this.items.add(tileObject.type);
      world.setAtCoordinate(tileObject.x, tileObject.y, TileType.GROUND);
    }
  }
  
  void addDeathToNarration(Monster monster)
  {
    addToNarration("You got killed by a ${monster.type.NAME}", "red");
  }
}