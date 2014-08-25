library ENTITY;

import '../World/TileObject/TileObject.dart';
import '../Items/Item/ItemType.dart';
import '../Game.dart';
import '../Items/Weapon/WeaponType.dart';
import '../World/TileObject/TileType.dart';
import '../Items/Armor/ArmorType.dart';
import 'Player/Player.dart';

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
  
  Entity(int x, int y, var type) : super(x, y, type)
  {
    this.isOpaque = true;
    this.isSolid = true;
    this.tileObject = new TileObject(x, y, TileType.GROUND);
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