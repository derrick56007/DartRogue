library CHEST;

import 'Item.dart';
import 'ItemType.dart';
import '../../Game/Game.dart';
import '../Armor/ArmorType.dart';
import '../Weapon/WeaponType.dart';
import '../../Entity/Monster/MonsterType.dart';
import '../Enum.dart';
import 'dart:math';
import '../../ChooseRandom/ChooseRandom.dart';

class Chest extends Item
{
  Enum treasureType;
  Chest(Point point) : super(point, ItemType.TREASURECHEST)
  {
    if(RNG.nextInt(8) != 0)
    {
      switch (difficulty) //TODO whats chests contains based on level of difficulty
      {
        case 0:
          this.treasureType = level0.pick();
          break;
        case 1:
          this.treasureType = level1.pick();
          break;
        case 2:
          this.treasureType = level2.pick();
          break;
        case 3:
          this.treasureType = level3.pick();
          break;
        case 4:
          this.treasureType = level4.pick();
          break;
        case 5:
          this.treasureType = level5.pick();
          break;
        case 6:
          this.treasureType = level6.pick();
          break;
        case 7:
          this.treasureType = level7.pick();
          break;
        case 8:
          this.treasureType = level8.pick();
          break;
        case 9:
          this.treasureType = level9.pick();
          break;
        case 10:
          this.treasureType = level10.pick();
          break;
        default:
          break;
      }
    }
    else
    {
      this.treasureType = troll.pick();
    }
    this.isWalkable = false;
  }
}

final ChooseRandom level0 = new ChooseRandom(loopList : [[35, ArmorType.LEADARMOR], [15, ArmorType.TINARMOR], [35, WeaponType.LEADBAR], [15, WeaponType.TINCROWBAR]]);
final ChooseRandom level1 = new ChooseRandom(loopList :[[35, ArmorType.ZINCARMOR], [15, ArmorType.GOLDARMOR], [35, WeaponType.ZINCCLUB], [15, WeaponType.GOLDHAMMER]]);
final ChooseRandom level2 = new ChooseRandom(loopList :[[35, ArmorType.SILVERARMOR], [15, ArmorType.ALUMINUMARMOR], [35, WeaponType.SILVERSLEDGEHAMMER], [15, WeaponType.ALUMINUMHATCHET]]);
final ChooseRandom level3 = new ChooseRandom(loopList :[[35, ArmorType.COPPERARMOR], [15, ArmorType.BRASSARMOR], [35, WeaponType.COPPERAXE], [15, WeaponType.BRASSSHORTSWORD]]);
final ChooseRandom level4 = new ChooseRandom(loopList :[[35, ArmorType.BRONZEARMOR], [15, ArmorType.NICKELARMOR], [35, WeaponType.BRONZECUTLASS], [15, WeaponType.NICKELRAPIER]]);
final ChooseRandom level5 = new ChooseRandom(loopList :[[35, ArmorType.PLATINUMARMOR], [15, ArmorType.STEELARMOR], [35, WeaponType.PLATINUMLONGSWORD], [15, WeaponType.STEELFLAMBARD]]);
final ChooseRandom level6 = new ChooseRandom(loopList :[[35, ArmorType.IRONARMOR], [15, ArmorType.PALLADIUMARMOR], [35, WeaponType.IRONVIKINGSWORD], [15, WeaponType.PALLADIUMRHINDON]]);
final ChooseRandom level7 = new ChooseRandom(loopList :[[35, ArmorType.RHODIUMARMOR], [15, ArmorType.TITANIUMARMOR], [35, WeaponType.RHODIUMDAYWALKER], [15, WeaponType.TITANIUMSCYTHE]]);
final ChooseRandom level8 = new ChooseRandom(loopList :[[35, ArmorType.HARDENEDSTEELARMOR], [15, ArmorType.TUNGSTENARMOR], [35, WeaponType.HARDENEDSTEELEXCALIBUR], [15, WeaponType.TUNGSTENGODRICSSWORD]]);
final ChooseRandom level9 = new ChooseRandom(loopList :[[35, ArmorType.TUNGSTENCARBIDEARMOR], [15, ArmorType.DIAMONDARMOR], [35, WeaponType.TUNGSTENCARBIDEANDURIL], [15, WeaponType.DIAMONDHIROSSWORD]]);
final ChooseRandom level10 = new ChooseRandom(loopList :[[35, ArmorType.HULKARMOR], [15, ArmorType.NOKIAARMOR], [35, WeaponType.ADAMANTIUMCLAWS], [15, WeaponType.LIGHTSABER]]);

final ChooseRandom troll = new ChooseRandom(loopList : [[100, MonsterType.GOBLIN]]);







