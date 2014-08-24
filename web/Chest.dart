library CHEST;

import 'Item.dart';
import 'ItemType.dart';
import 'Game.dart';
import 'ArmorType.dart';
import 'WeaponType.dart';
import 'Armor.dart';
import 'Weapon.dart';

class Chest extends Item
{
  var treasure;
  Chest(int x, int y) : super(x, y, ItemType.TREASURECHEST)
  {
    var type = getRandomWeighted([[50, ArmorType.USEDIRONARMOR], [50, ArmorType.IRONARMOR]]);
    if(type is ArmorType)
    {
      treasure = new Armor(x, y, type);
    }
    else if(type is WeaponType)
    {
      treasure = new Weapon(x, y, type);
    }
    else if(type is ItemType)
    {
      treasure = new Item(x, y, type);
    }
  }
}