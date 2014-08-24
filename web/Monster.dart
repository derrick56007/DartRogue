library MONSTER;

import 'Entity.dart';
import 'TileObject.dart';
import 'Game.dart';
import 'Player.dart';
import 'MonsterType.dart';
import 'TileType.dart';
import 'dart:math';
import 'ItemType.dart';
import 'dartrogue.dart';

class Monster extends Entity
{
  int COUNTMAX = 0;
  int followingCountdown = 0;
  int followX, followY;
  List pathToPlayer = [];
  Random rng;
  
  Monster(int x, int y, TileObject tileObject, var type) : super(x, y, tileObject, type)
  {
    this.isSolid = true;
    this.isWalkable = false;
    setAttributes();
    this.HP = this.MAXHP;
    this.items.add(ItemType.KEY);
    this.rng = new Random(RNG.nextInt(1 << 32));
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
    else
    {
      moveIdle();
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
  
  void moveIdle()
  {
    if(this.rng.nextInt(5) == 0)
    {
      int moveX = rng.nextInt(3) - 1;
      int moveY = rng.nextInt(3) - 1;
      if(!world.grid.nodes[this.y + moveY][this.x + moveX].isSolid)
      {
        moveTo(this.x + moveX, this.y + moveY);
      }
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
      doWhenDead();
    }
  }
  
  void doWhenDead()
  {
    if(this.type == MonsterType.KEYHOLDER)
    {
      world.setAtCoordinate(this.x, this.y, ItemType.KEY);
    }
    else
    {
      if(this.rng.nextInt(3) == 0 && this.items.length > 0)
      {
        world.setAtCoordinate(this.x, this.y, this.items[this.rng.nextInt(this.items.length)]);
      }
      else
      {
        if(!(world.grid.nodes[this.y][this.x].type is ItemType))
        {
          world.setAtCoordinate(this.x, this.y, TileType.BONES);
        }
      }
      world.monsters.remove(this);
      enemyStats.style.opacity = "0";
    }
    addToNarration("You killed a ${this.type.NAME}!", "green");
  }
}