library CHEST;

import 'Item.dart';
import 'ItemType.dart';
import 'Game.dart';
import 'ArmorType.dart';
import 'WeaponType.dart';
import 'TileType.dart';
import 'MonsterType.dart';
import 'Enum.dart';

class Chest extends Item
{
  Enum treasureType;
  Chest(int x, int y) : super(x, y, ItemType.TREASURECHEST)
  {
    if(RNG.nextInt(4) == 5)
    switch (difficulty) //TODO whats chests contains based on level of difficulty
    {
      case 0:
        this.treasureType = getRandomWeighted([[35, ArmorType.LEADARMOR], [15, ArmorType.TINARMOR], [35, WeaponType.LEADBAR], [15, WeaponType.TINCROWBAR]]);
        break;
      case 1:
        this.treasureType = getRandomWeighted([[35, ArmorType.ZINCARMOR], [15, ArmorType.GOLDARMOR], [35, WeaponType.ZINCCLUB], [15, WeaponType.GOLDHAMMER]]);
        break;
      case 2:
        this.treasureType = getRandomWeighted([[35, ArmorType.SILVERARMOR], [15, ArmorType.ALUMINUMARMOR], [35, WeaponType.SILVERSLEDGEHAMMER], [15, WeaponType.ALUMINUMHATCHET]]);
        break;
      case 3:
        this.treasureType = getRandomWeighted([[35, ArmorType.COPPERARMOR], [15, ArmorType.BRASSARMOR], [35, WeaponType.COPPERAXE], [15, WeaponType.BRASSSHORTSWORD]]);
        break;
      case 4:
        this.treasureType = getRandomWeighted([[35, ArmorType.BRONZEARMOR], [15, ArmorType.NICKELARMOR], [35, WeaponType.BRONZECUTLASS], [15, WeaponType.NICKELRAPIER]]);
        break;
      case 5:
        this.treasureType = getRandomWeighted([[35, ArmorType.PLATINUMARMOR], [15, ArmorType.STEELARMOR], [35, WeaponType.PLATINUMLONGSWORD], [15, WeaponType.STEELFLAMBARD]]);
        break;
      case 6:
        this.treasureType = getRandomWeighted([[35, ArmorType.IRONARMOR], [15, ArmorType.PALLADIUMARMOR], [35, WeaponType.IRONVIKINGSWORD], [15, WeaponType.PALLADIUMRHINDON]]);
        break;
      case 7:
        this.treasureType = getRandomWeighted([[35, ArmorType.RHODIUMARMOR], [15, ArmorType.TITANIUMARMOR], [35, WeaponType.RHODIUMDAYWALKER], [15, WeaponType.TITANIUMSCYTHE]]);
        break;
      case 8:
        this.treasureType = getRandomWeighted([[35, ArmorType.HARDENEDSTEELARMOR], [15, ArmorType.TUNGSTENARMOR], [35, WeaponType.HARDENEDSTEELEXCALIBUR], [15, WeaponType.TUNGSTENGODRICSSWORD]]);
        break;
      case 9:
        this.treasureType = getRandomWeighted([[35, ArmorType.TUNGSTENCARBIDEARMOR], [15, ArmorType.DIAMONDARMOR], [35, WeaponType.TUNGSTENCARBIDEANDURIL], [15, WeaponType.DIAMONDHIROSSWORD]]);
        break;
      case 10:
        this.treasureType = getRandomWeighted([[35, ArmorType.HULKARMOR], [15, ArmorType.NOKIAARMOR], [35, WeaponType.ADAMANTIUMCLAWS], [15, WeaponType.LIGHTSABER]]);
        break;
      default:
        break;
    }
    else
    {
      this.treasureType = getRandomWeighted([[75, TileType.GROUND], [25, MonsterType.GOBLIN]]); //TODO bad chest items
    }
  }
}