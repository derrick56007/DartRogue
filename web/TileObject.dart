library TILEOBJECT;

import 'Game.dart';
import 'TileType.dart';

class TileObject
{
  var type;
  bool isOpaque;
  bool isVisible =  allVisible;
  bool isSolid = false;
  bool isWalkable = false;
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
      this.isWalkable = false;
    }
    else if(this.type == TileType.GROUND)
    {
      this.isSolid = false;
      this.isOpaque = true;
      this.isWalkable = true;
    }
    else if(this.type == TileType.STONE)
    {
      this.isSolid = true;
      this.isOpaque = false;
      this.isWalkable = false;
    }
  }
}