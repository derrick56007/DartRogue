library TILEOBJECT;

import 'Game.dart';
import 'TileType.dart';

class TileObject
{
  var type;
  bool isOpaque;
  bool isVisible =  allVisible;
  bool isSolid = false;
  int x;
  int y;
  String toString() => "${type.toString()}";
  
  TileObject(this.x, this.y, this.type)
  {
    if(this.type == TileType.WALL)
    {
      this.isSolid = true;
      this.isOpaque = false;
    }
    if(this.type == TileType.GROUND)
    {
      this.isSolid = false;
      this.isOpaque = true;
    }
  }
}