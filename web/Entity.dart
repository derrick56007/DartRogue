library ENTITY;

import 'TileObject.dart';

class Entity extends TileObject
{
  int atk;
  int def;
  int HP;
  int MAXHP;
  List items;
  TileObject tileObject;
  
  Entity(int x, int y, this.tileObject, var type) : super(x, y, type)
  {
    this.isOpaque = true;
    this.isSolid = true;
  }
}