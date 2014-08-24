library ITEM;

import 'TileObject.dart';

class Item extends TileObject
{
  String decription;
  Item(int x, int y, var type) : super(x, y, type)
  {
    this.isSolid = true;
    this.isOpaque = true;
    this.isWalkable = !this.isSolid;
  }
}