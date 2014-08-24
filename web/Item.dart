library ITEM;

import 'TileObject.dart';
import 'Enum.dart';

class Item extends TileObject
{
  String decription;
  Item(int x, int y, Enum type) : super(x, y, type)
  {
    this.isSolid = false;
    this.isOpaque = true;
    this.isWalkable = true;
  }
}