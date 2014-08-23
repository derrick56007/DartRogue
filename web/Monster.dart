library MONSTER;

import 'Entity.dart';
import 'TileObject.dart';
import 'Game.dart';
import 'Player.dart';
import 'MonsterType.dart';

class Monster extends Entity
{
  int COUNTMAX = 0;
  int followingCountdown = 0;
  int followX, followY;
  List pathToPlayer = [];
  Monster(int x, int y, TileObject tileObject, var type) : super(x, y, tileObject, type)
  {
    this.isSolid = true;
    this.isWalkable = false;
    setAttributes();
    this.HP = this.MAXHP;
  }
  
  void setAttributes()
  {
    switch(this.type)
    {
      case MonsterType.GOBLIN:
        this.MAXHP = 5;
        this.atk = 1;
        this.COUNTMAX = 6;
        break;
      default:
        break;
    }
  }
  
  void timeStep()
  {
    if(followingCountdown > 0)
    {
      followingCountdown--;
      if(this.pathToPlayer.length > 2)
      {
        moveTowardsPlayer();
      }
      else
      {
        world.player.getAttackedWithDmg(this);
      }
    }
  }
  
  void moveTowardsPlayer()
  {
    if(!world.grid.nodes[pathToPlayer[1][1]][pathToPlayer[1][0]].isSolid)
    {
      world.grid.nodes[this.tileObject.y][this.tileObject.x] = this.tileObject;
      this.x = pathToPlayer[1][0];
      this.y = pathToPlayer[1][1];
      this.tileObject = world.grid.nodes[this.y][this.x];
      world.grid.nodes[this.y][this.x] = this;
    }
  }
  
  void followCountSetMax()
  {
    this.followingCountdown = COUNTMAX;
  }
  
  void getAttackedWithDmg(Player player)
  {
    takeDmg(player);
    addToNarration("You attack a "+ "${this.type}! (${player.atk} dmg)".toLowerCase(), "black");
    if(this.HP > 0)
    {
      refreshStats(this);
    }
    else
    {
      enemyStats.style.opacity = "0";
    }
  }
}