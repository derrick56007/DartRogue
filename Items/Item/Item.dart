library ITEM;

import '../../World/TileObject/TileObject.dart';
import '../Enum.dart';
import 'dart:math';

class Item extends TileObject
{
  String decription;
  Item(Point point, Enum type) : super(point, type)
  {
    this.isSolid = false;
    this.isOpaque = true;
    this.isWalkable = true;
  }
}