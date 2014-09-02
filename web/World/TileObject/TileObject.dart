library TILEOBJECT;

import '../../Game/Game.dart';
import 'TileType.dart';
import '../../Items/Enum.dart';
import 'dart:math';

/*
 * Basis of all objects in the game grid
 */
class TileObject
{
  Enum type;
  bool isOpaque;
  bool isVisible =  !shadowsOn;
  bool isSolid = false;
  bool isWalkable;
  Point point;
  num g, h, f;
  bool opened, closed;
  TileObject parent;
  String toString() => "${type.toString()}";

  TileObject(this.point, this.type)
  {
    if(this.type == TileType.WALL)
    {
      this.isSolid = true;
      this.isOpaque = false;
      this.isWalkable = !this.isSolid;
    }
    else if(this.type == TileType.GROUND)
    {
      this.isSolid = false;
      this.isOpaque = true;
      this.isWalkable = !this.isSolid;
    }
    else if(this.type == TileType.STONE)
    {
      this.isSolid = true;
      this.isOpaque = false;
      this.isWalkable = !this.isSolid;
    }
    else if(this.type == TileType.BONES)
    {
      this.isSolid = false;
      this.isOpaque = true;
      this.isWalkable = !this.isSolid;
    }
    else if(this.type == TileType.SPIKE)
    {
      this.isSolid = false;
      this.isOpaque = true;
      this.isWalkable = true;
    }
    else if(this.type == TileType.PROJECTILE)
    {
      this.isSolid = true;
      this.isOpaque = true;
      this.isWalkable = false;
    }
  }
}