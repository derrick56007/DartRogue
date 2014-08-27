library ARMOR;

import '../Item/Item.dart';
import 'dart:math';

class Armor extends Item
{
  int def;
  Armor(Point point, var type) : super(point, type)
  {
    this.def = type.def;
  }
}