library PLAYER;

import 'Entity.dart';
import 'TileObject.dart';

class Player extends Entity
{
  Player(int x, int y, TileObject tileObject, var type) : super(x, y, tileObject, type)
  {
    this.isWalkable = true;
  }
}