library ENTITY;

import 'TileObject.dart';

class Entity extends TileObject
{
  int atk = 0;
  int def = 0;
  int MAXHP = 0;
  int HP = 0;
  List items = [];
  TileObject tileObject;
  
  Entity(int x, int y, this.tileObject, var type) : super(x, y, type)
  {
    this.isOpaque = true;
    this.isSolid = true;
  }
  
  void takeDmg(Entity entity)
  {
    int damage = this.def - entity.atk;
    if(damage <= 0)
    {
      damage = 1;
    }
    this.HP -= damage;
  }
}