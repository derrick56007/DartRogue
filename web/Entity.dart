library ENTITY;

import 'TileObject.dart';

class Entity extends TileObject
{
  int atk;
  int def;
  List items;
  
  Entity(int x, int y, var type) : super(x, y, type);
}