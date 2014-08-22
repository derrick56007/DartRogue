library MONSTER;

import 'Entity.dart';
import 'TileObject.dart';
import 'Game.dart';
import 'Player.dart';

class Monster extends Entity
{
  int COUNTMAX = 6;
  int followingCountdown = 0;
  int followX, followY;
  List pathToPlayer = [];
  Monster(int x, int y, TileObject tileObject, var type) : super(x, y, tileObject, type)
  {
    this.isSolid = true;
    this.isWalkable = false;
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
        print("attack");
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
}