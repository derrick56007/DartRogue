library TILEOBJECT;

import '../../Game.dart';
import 'TileType.dart';
import '../../Items/Enum.dart';

class TileObject
{
  Enum type;
  bool isOpaque;
  bool isVisible =  allVisible;
  bool isSolid = false;
  bool isWalkable;
  int x;
  int y;
  num g, h, f;
  bool opened, closed;
  TileObject parent;
  String toString() => "${type.toString()}";
  
  TileObject(this.x, this.y, this.type)
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
  }
}