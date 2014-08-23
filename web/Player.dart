library PLAYER;

import 'Entity.dart';
import 'TileObject.dart';
import 'PlayerType.dart';
import 'Game.dart';

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
  
  void getAttackedWithDmg(Entity entity)
  {
    takeDmg(entity);
    addToNarration("A" + " ${entity.type} attacks you! (${entity.atk} dmg)".toLowerCase(), "red");
    if(this.HP > 0)
    {
      refreshStats(this);
    }
    else
    {
      print("you died!");
    }
  }
}