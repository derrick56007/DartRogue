library WEAPONTYPE;

import '../Enum.dart';

class WeaponType<String> extends Enum<String, String>
{
  final int atk;
  const WeaponType(String val, String name, this.atk) : super(val, name);
  
  static const WeaponType NONE = const WeaponType("W", "knuckles", 0);
  
  static const WeaponType LEADBAR = const WeaponType("W", "a lead bar", 1);
  
  static const WeaponType TINCROWBAR = const WeaponType("W", "a tin crowbar", 2);
  
  static const WeaponType ZINCCLUB = const WeaponType("W", "a zinc club", 3);
  
  static const WeaponType GOLDHAMMER = const WeaponType("W", "a gold hammer", 4);
  
  static const WeaponType SILVERSLEDGEHAMMER = const WeaponType("W", "a silver sledgehammer", 5);
  
  static const WeaponType ALUMINUMHATCHET = const WeaponType("W", "a aluminum hatchet", 6);
  
  static const WeaponType COPPERAXE = const WeaponType("W", "a copper axe", 7);
  
  static const WeaponType BRASSSHORTSWORD = const WeaponType("W", "a brass shortsword", 8);
  
  static const WeaponType BRONZECUTLASS = const WeaponType("W", "a bronze cutlass", 9);
  
  static const WeaponType NICKELRAPIER = const WeaponType("W", "a nickel rapier", 10);
  
  static const WeaponType PLATINUMLONGSWORD = const WeaponType("W", "a platinum longsword", 11);
  
  static const WeaponType STEELFLAMBARD = const WeaponType("W", "a steel flambard", 12);
  
  static const WeaponType IRONVIKINGSWORD = const WeaponType("W", "a iron viking sword", 13);
  
  static const WeaponType PALLADIUMRHINDON = const WeaponType("W", "the rhindon", 14);
  
  static const WeaponType RHODIUMDAYWALKER = const WeaponType("W", "the daywalker", 15);
  
  static const WeaponType TITANIUMSCYTHE = const WeaponType("W", "a titanim scythe", 16);
  
  static const WeaponType HARDENEDSTEELEXCALIBUR = const WeaponType("W", "the excalibur", 17);
  
  static const WeaponType TUNGSTENGODRICSSWORD = const WeaponType("W", "Godric's sword", 18);
  
  static const WeaponType TUNGSTENCARBIDEANDURIL = const WeaponType("W", "the anduril", 19);
  
  static const WeaponType DIAMONDHIROSSWORD = const WeaponType("W", "Hiro's sword", 20);
  
  static const WeaponType ADAMANTIUMCLAWS = const WeaponType("W", "adamantium claws", 21);
  
  static const WeaponType LIGHTSABER = const WeaponType("W", "a saber of light", 22);
}