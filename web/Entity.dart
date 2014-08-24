library ENTITY;

import 'TileObject.dart';
import 'ItemType.dart';
import 'Game.dart';
import 'WeaponType.dart';
import 'TileType.dart';
import 'ArmorType.dart';
import 'Player.dart';

class Entity extends TileObject
{
  int atk = 0;
  int def = 0;
  int MAXHP = 0;
  int HP = 0;
  List<ItemType> items = [];
  ArmorType armor =  ArmorType.NONE;
  WeaponType weapon =  WeaponType.NONE;
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
  
  Entity(int x, int y, var type) : super(x, y, type)
  {
    this.isOpaque = true;
    this.isSolid = true;
    this.tileObject = new TileObject(x, y, TileType.GROUND);
  }
  
  int takeDmg(Entity entity)
  {
    int damage = (this.def + this.armor.def) - (entity.atk + entity.weapon.atk);
    if(damage <= 0)
    {
      damage = 1;
    }
    this.HP -= damage;
    return damage;
  }
  
  void moveTo(x, y)
  {
    world.grid.nodes[this.tileObject.y][this.tileObject.x] = this.tileObject;
    this.x = x;
    this.y = y;
    this.tileObject = world.grid.nodes[this.y][this.x];
    world.grid.nodes[this.y][this.x]= this; 
    if(this.tileObject.type == TileType.SPIKE)
    {
      this.HP -= 1;
      if(this is Player)
      {
        addToNarration("You stepped on spikes", "red");
      }
    }
  }
  
  void doWhenDead()
  {
    
  }
}