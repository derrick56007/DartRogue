library WEAPON;

import '../Item/Item.dart';

class Weapon extends Item
{
  int atk;
  Weapon(int x, int y, var type) : super(x, y, type);
}