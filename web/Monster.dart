library MONSTER;

import 'Entity.dart';
import 'TileObject.dart';

class Monster extends Entity
{
  Monster(int x, int y, TileObject tileObject, var type) : super(x, y, tileObject, type);
}