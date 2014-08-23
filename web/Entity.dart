library ENTITY;

import 'TileObject.dart';
import 'Enum.dart';

class Entity extends TileObject
{
  int atk = 0;
  int def = 0;
  int MAXHP = 0;
  int HP = 0;
  List<Enum> items = [];
  TileObject tileObject;
  itemToString() => getItemNames();
  
  String getItemNames()
  {
    String string = "";
    for(int i = 0, length = items.length; i < length; i++)
    {
      if(i == length - 1)
      {
        string = string + items[i].NAME;
      }
      else
      {
        string = string + items[i].NAME + ", ";
      }
    }
    return string;
  }
  
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