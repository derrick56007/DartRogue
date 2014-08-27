library ENTITY;

import '../World/TileObject/TileObject.dart';
import '../Items/Item/ItemType.dart';
import '../Game.dart';
import '../Items/Weapon/WeaponType.dart';
import '../World/TileObject/TileType.dart';
import '../Items/Armor/ArmorType.dart';
import 'Player/Player.dart';
import 'dart:math';

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
    Map map = new Map();
    for(int i = 0, length = items.length; i < length; i++)
    {
      if(map.containsKey(items[i].NAME))
      {
        map[items[i].NAME] = map[items[i].NAME] + 1;
      }
      else
      {
        map[items[i].NAME] = 1;
      }
    }
    
    String string = "";
    for(var key in map.keys)
    {
      string = "${string}" + "${key}".toUpperCase() + " x ${map[key]},";
    }
    return string;
  }
  
  Entity(Point point, var type) : super(point, type)
  {
    this.isOpaque = true;
    this.isSolid = true;
    this.tileObject = new TileObject(point, TileType.GROUND);
  }
  
  int takeDmg(Entity entity)
  {
    int damage = (entity.atk + entity.weapon.atk) -  (this.def + this.armor.def);
    if(damage <= 0)
    {
      damage = 1;
    }
    this.HP -= damage;
    return damage;
  }
  
  void moveTo(Point point)
  {
    world.setAtPoint(this.tileObject.point, this.tileObject);
    this.point = new Point(point.x, point.y);
    this.tileObject = world.getAtPoint(this.point);
    world.setAtPoint(this.point, this);
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