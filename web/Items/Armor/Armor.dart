library ARMOR;

import '../Item/Item.dart';

class Armor extends Item
{
  int def;
  Armor(int x, int y, var type) : super(x, y, type)
  {
    this.def = type.def;
  }
}