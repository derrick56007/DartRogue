library MONSTER;

import 'Entity.dart';
import 'TileObject.dart';
import 'Game.dart';
import 'Player.dart';
import 'MonsterType.dart';
import 'TileType.dart';
import 'dart:math';
import 'ItemType.dart';

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
    this.items.add(ItemType.KEY);
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
    if(this.followingCountdown > 0)
    {
      this.followingCountdown--;
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
    addToNarration("You attack a ${this.type.NAME}! (${player.atk} dmg)", "black");
    if(this.HP > 0)
    {
      refreshStats(this);
    }
    else
    {
      if(this.items.length > 0)
      {
        world.setAtCoordinate(this.x, this.y, this.items[new Random().nextInt(this.items.length)]);
      }
      else
      {
        world.setAtCoordinate(this.x, this.y, TileType.BONES);
      }
      world.monsters.remove(this);
      enemyStats.style.opacity = "0";
    }
  }
}