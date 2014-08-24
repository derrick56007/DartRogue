library ARMOR;

import 'Item.dart';
import 'ArmorType.dart';

class Armor extends Item
{
  int def;
  Armor(int x, int y, ArmorType type) : super(x, y, type)
  {
    this.def = type.def;
  }
}