library WEAPON;

import 'Item.dart';
import 'Enum.dart';

class Weapon extends Item
{
  int atk;
  Weapon(int x, int y, Enum type) : super(x, y, type);
}