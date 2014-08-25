library WEAPONTYPE;

import '../Enum.dart';

class WeaponType<String> extends Enum<String, String>
{
  final int atk;
  const WeaponType(String val, String name, this.atk) : super(val, name);
  
  static const WeaponType NONE = const WeaponType("W", "knuckles", 0);
  
  static const WeaponType LEADBAR = const WeaponType("A", "a lead bar", 1);
  
  static const WeaponType TINCROWBAR = const WeaponType("A", "a tin crowbar", 2);
  
  static const WeaponType ZINCCLUB = const WeaponType("A", "a zinc club", 3);
  
  static const WeaponType GOLDHAMMER = const WeaponType("A", "a gold hammer", 4);
  
  static const WeaponType SILVERSLEDGEHAMMER = const WeaponType("A", "a silver sledgehammer", 5);
  
  static const WeaponType ALUMINUMHATCHET = const WeaponType("A", "a aluminum hatchet", 6);
  
  static const WeaponType COPPERAXE = const WeaponType("A", "a copper axe", 7);
  
  static const WeaponType BRASSSHORTSWORD = const WeaponType("A", "a brass shortsword", 8);
  
  static const WeaponType BRONZECUTLASS = const WeaponType("A", "a bronze cutlass", 9);
  
  static const WeaponType NICKELRAPIER = const WeaponType("A", "a nickel rapier", 10);
  
  static const WeaponType PLATINUMLONGSWORD = const WeaponType("A", "a platinum longsword", 11);
  
  static const WeaponType STEELFLAMBARD = const WeaponType("A", "a steel flambard", 12);
  
  static const WeaponType IRONVIKINGSWORD = const WeaponType("A", "a iron viking sword", 13);
  
  static const WeaponType PALLADIUMRHINDON = const WeaponType("A", "the rhindon", 14);
  
  static const WeaponType RHODIUMDAYWALKER = const WeaponType("A", "the daywalker", 15);
  
  static const WeaponType TITANIUMSCYTHE = const WeaponType("A", "a titanim scythe", 16);
  
  static const WeaponType HARDENEDSTEELEXCALIBUR = const WeaponType("A", "the excalibur", 17);
  
  static const WeaponType TUNGSTENGODRICSSWORD = const WeaponType("A", "Godric's sword", 18);
  
  static const WeaponType TUNGSTENCARBIDEANDURIL = const WeaponType("A", "the anduril", 19);
  
  static const WeaponType DIAMONDHIROSSWORD = const WeaponType("A", "Hiro's sword", 20);
  
  static const WeaponType ADAMANTIUMCLAWS = const WeaponType("A", "adamantium claws", 21);
  
  static const WeaponType LIGHTSABER = const WeaponType("A", "a saber of light", 22);
}