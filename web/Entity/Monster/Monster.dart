library MONSTER;

import '../Entity.dart';
import '../../Game/Game.dart';
import '../Player/Player.dart';
import 'MonsterType.dart';
import '../../World/TileObject/TileType.dart';
import 'dart:math';
import '../../Items/Item/ItemType.dart';
import '../Pathfinding/astar.dart';
import '../../World/World.dart';
import '../../Game/Visual/Display.dart';

class Monster extends Entity
{
  int COUNTMAX = 0;
  int followingCountdown = 0;
  int followX, followY;
  List pathToPlayer = [];
  Random rng;

  Monster(Point point, MonsterType type) : super(point, type)
  {
    this.isSolid = true;
    this.isWalkable = false;
    setAttributes();
    this.HP = this.MAXHP;
    this.items.add(ItemType.KEY);
    this.rng = new Random(RNG.nextInt(pow(2, 32)));
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
      case MonsterType.LIZARD:
        this.MAXHP = 5;
        this.atk = 1;
        this.COUNTMAX = 4;
        break;
      default:
        break;
    }
  }

  void timeStep(World world)
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
        world.player.getAttackedWithDmg(this, true);
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
      world.setAtPoint(this.tileObject.point, this.tileObject);
      this.point = new Point(this.pathToPlayer[1][0], this.pathToPlayer[1][1]);
      this.tileObject = world.getAtPoint(this.point);
      world.setAtPoint(this.point, this);
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
      while(!world.getAtPoint(new Point(player.point.x + moveX, player.point.y + moveY)).isWalkable)
      {
        moveX = rng.nextInt(3) - 1;
        moveY = rng.nextInt(3) - 1;
      }
      this.pathToPlayer = new AStarFinder().findPath(this.point, new Point(player.point.x + moveX, player.point.y + moveY), world.grid.clone());
      moveTowardsPlayer();
    }
  }

  void moveIdle()
  {
    if(this.rng.nextInt(5) == 0)
    {
      int moveX = rng.nextInt(3) - 1;
      int moveY = rng.nextInt(3) - 1;
      if(this.point.y + moveY < world.grid.nodes.length && this.point.x + moveX < world.grid.nodes[0].length)
      {
        if(!world.getAtPoint(new Point(this.point.x + moveX, this.point.y + moveY)).isSolid)
        {
          moveTo(new Point(this.point.x + moveX, this.point.y + moveY));
        }
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
    display.addToNarration("You attack a ${this.type.NAME}! (${player.atk + player.weapon.atk} dmg)", "black");
    if(this.HP > 0)
    {
      display.refreshStats(this);
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
      world.setTileTypeAtPoint(this.point, ItemType.KEY);
    }
    else
    {
      if(this.rng.nextInt(3) == 0 && this.items.length > 0)
      {
        world.setTileTypeAtPoint(this.point, this.items[this.rng.nextInt(this.items.length)]);
      }
      else
      {
        world.setTileTypeAtPoint(this.point, tileObject.type);
      }
      world.monsters.remove(this);
      enemyStats.style.opacity = "0";
    }
    display.addToNarration("You kill a ${this.type.NAME}!", "green");
  }
}