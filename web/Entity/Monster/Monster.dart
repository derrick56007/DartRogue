library MONSTER;

import '../Entity.dart';
import '../../Game.dart';
import '../Player/Player.dart';
import 'MonsterType.dart';
import '../../World/TileObject/TileType.dart';
import 'dart:math';
import '../../Items/Item/ItemType.dart';
import '../Pathfinding/astar.dart';

class Monster extends Entity
{
  int COUNTMAX = 0;
  int followingCountdown = 0;
  int followX, followY;
  List pathToPlayer = [];
  Random rng;
  
  Monster(int x, int y, MonsterType type) : super(x, y, type)
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
    switch(this.type) //TODO attributes based on difficulty
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
    if(world.grid.nodes[pathToPlayer[1][1]][pathToPlayer[1][0]].isWalkable)
    {
      world.grid.nodes[this.tileObject.y][this.tileObject.x] = this.tileObject;
      this.x = pathToPlayer[1][0];
      this.y = pathToPlayer[1][1];
      this.tileObject = world.grid.nodes[this.y][this.x];
      world.grid.nodes[this.y][this.x] = this;
      if(this.tileObject.type == TileType.SPIKE)
      {
        this.HP -= 1;
      }
    }
    else
    {
      Player player = world.player;
      int moveX = rng.nextInt(3) - 1;
      int moveY = rng.nextInt(3) - 1;
      while(!world.grid.nodes[player.y + moveY][player.x + moveX].isWalkable)
      {
        moveX = rng.nextInt(3) - 1;
        moveY = rng.nextInt(3) - 1;
      }
      this.pathToPlayer = new AStarFinder().findPath(this.x, this.y, player.x + moveX, player.y + moveY, world.grid.clone());
      moveTowardsPlayer();
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
    addToNarration("You attack a ${this.type.NAME}! (${player.atk + player.weapon.atk} dmg)", "black");
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
        world.setAtCoordinate(this.x, this.y, tileObject.type);
      }
      world.monsters.remove(this);
      enemyStats.style.opacity = "0";
    }
    addToNarration("You killed a ${this.type.NAME}!", "green");
  }
}