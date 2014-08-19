library TILEOBJECT;

import 'Game.dart';

class TileObject
{
  var type;
  bool isOpaque;
  bool isVisible =  allVisible;
  int x;
  int y;
  String toString() => "${type.toString()}";
  
  TileObject(this.x, this.y, this.type);
}