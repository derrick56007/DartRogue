library RANGEDMONSTER;

import 'Monster.dart';
import 'dart:math';
import 'MonsterType.dart';
import '../../Game/Game.dart';
import '../../World/TileObject/TileObject.dart';
import '../../World/TileObject/TileType.dart';
import '../Entity.dart';
import '../../Items/Item/ItemType.dart';
import '../../World/World.dart';
import '../Player/Player.dart';

class RangedMonster extends Monster
{
  int MAXSHOTDELAY = 8;
  int delayCount = 0;
  Point projectile = null;
  List<Point> projectilePath = null;
  RangedMonster(Point point, MonsterType type) :super(point, type)
  {
    this.isSolid = true;
    this.isWalkable = false;
    setAttributes();
    this.HP = this.MAXHP;
    this.items.add(ItemType.KEY);
    this.rng = new Random(RNG.nextInt(pow(2, 32)));
    this.isVisible = !shadowsOn;
  }

  void timeStep(World world)
  {
    if(this.projectilePath != null)
    {
      moveProjectile(world);
    }
    else if(this.followingCountdown > 0)
    {
      this.followingCountdown--;
      if(this.pathToPlayer.length > 4)
      {
        moveTowardsPlayer();
      }
      else
      {
        moveIdle();
      }
    }
    else
    {
      moveIdle();
    }
    this.delayCount--;
  }

  setProjectilePath(World world)
  {
    if(this.projectilePath == null && this.delayCount <= 0)
    {
      this.projectilePath = [];
      Point point = this.point;
      Point point2 = world.player.point;
      int width = point2.x - point.x ;
      int height = point2.y - point.y ;

      int dx1 = 0;
      int dy1 = 0;
      int dx2 = 0;
      int dy2 = 0 ;

      if(width < 0)
      {
        dx1 = -1;
      }
      else if(width > 0)
      {
        dx1 = 1;
      }

      if(height < 0)
      {
        dy1 = -1;
      }
      else if(height > 0)
      {
        dy1 = 1;
      }

      if(width < 0)
      {
        dx2 = -1;
      }
      else if(width > 0)
      {
        dx2 = 1;
      }

      int longest = width.abs();
      int shortest = height.abs();
      if(!(longest > shortest))
      {
          longest = height.abs() ;
          shortest = width.abs() ;
          if(height < 0)
          {
            dy2 = -1;
          }
          else if(height > 0)
          {
            dy2 = 1;
          }
          dx2 = 0;
      }

      int numerator = longest >> 1 ;
      for (int i = 0;i <= longest;i++)
      {
        this.projectilePath.add( point);

        numerator += shortest ;
        if(!(numerator < longest))
        {
            numerator -= longest ;
            point = new Point(point.x + dx1, point.y + dy1);
        }
        else
        {
            point = new Point(point.x + dx2, point.y + dy2);
        }
      }
      this.delayCount = this.MAXSHOTDELAY;
      this.projectile = this.projectilePath[1];
    }
  }

  void moveProjectile(World world)
  {
    if(this.projectilePath.length > 0)
    {
      if(this.projectilePath.length > 1)
      {
        this.projectilePath.removeAt(0);
      }

      TileObject tileToMoveTo = world.getAtPoint(this.projectilePath.first);
      if(tileToMoveTo.type == TileType.GROUND)
      {
        removeProjectile(world);
        this.projectile = this.projectilePath.first;
        world.setTileTypeAtPoint(this.projectile, TileType.PROJECTILE);
      }
      else if(tileToMoveTo is Entity)
      {
        Entity entity = tileToMoveTo;
        if(entity is Player)
        {
          world.player.getAttackedWithDmg(this, false);
        }
        else if(!(tileToMoveTo is RangedMonster))
        {
          entity.takeDmg(this);
        }
        removeProjectile(world);
        erasePath();
      }
      else
      {
        removeProjectile(world);
        erasePath();
      }
    }
  }

  void removeProjectile(World world)
  {
    if(world.getAtPoint(this.projectile).type == TileType.PROJECTILE)
    {
      world.setTileTypeAtPoint(this.projectile, TileType.GROUND);
    }
  }

  void erasePath()
  {
    this.projectilePath = null;
  }
}