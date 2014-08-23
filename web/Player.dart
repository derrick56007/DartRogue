library PLAYER;

import 'Entity.dart';
import 'TileObject.dart';
import 'PlayerType.dart';
import 'Game.dart';
import 'Monster.dart';

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
    takeDmg(monster);
    addToNarration("A ${monster.type.NAME} attacks you! (${monster.atk} dmg)", "red");
    if(this.HP > 0)
    {
      refreshStats(this);
      monster.getAttackedWithDmg(this);
    }
    else
    {
      print("you died!");
    }
  }
}