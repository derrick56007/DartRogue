library ARMORTYPE;

import 'Enum.dart';

class ArmorType<String> extends Enum<String, String>
{
  final int def;
  const ArmorType(String val, String name, this.def) : super(val, name);
  
  static const ArmorType NONE = const ArmorType("A", "the clothes on your back", 0);
  
  static const ArmorType LEADARMOR = const ArmorType("A", "lead armor", 1);
  
  static const ArmorType TINARMOR = const ArmorType("A", "tin armor", 2);
  
  static const ArmorType ZINCARMOR = const ArmorType("A", "zinc armor", 3);
  
  static const ArmorType GOLDARMOR = const ArmorType("A", "gold armor", 4);
  
  static const ArmorType SILVERARMOR = const ArmorType("A", "silver armor", 5);
  
  static const ArmorType ALUMINUMARMOR = const ArmorType("A", "aluminum armor", 6);
  
  static const ArmorType COPPERARMOR = const ArmorType("A", "copper armor", 7);
  
  static const ArmorType BRASSARMOR = const ArmorType("A", "brass armor", 8);
  
  static const ArmorType BRONZEARMOR = const ArmorType("A", "bronze armor", 9);
  
  static const ArmorType NICKELARMOR = const ArmorType("A", "nickel armor", 10);
  
  static const ArmorType PLATINUMARMOR = const ArmorType("A", "platinum armor", 11);
  
  static const ArmorType STEELARMOR = const ArmorType("A", "steel armor", 12);
  
  static const ArmorType IRONARMOR = const ArmorType("A", "iron armor", 13);
  
  static const ArmorType PALLADIUMARMOR = const ArmorType("A", "palladium armor", 14);
  
  static const ArmorType RHODIUMARMOR = const ArmorType("A", "rhodium armor", 15);
  
  static const ArmorType TITANIUMARMOR = const ArmorType("A", "titanium armor", 16);
  
  static const ArmorType HARDENEDSTEELARMOR = const ArmorType("A", "hardened steel armor", 17);
  
  static const ArmorType TUNGSTENARMOR = const ArmorType("A", "tungsten armor", 18);
  
  static const ArmorType TUNGSTENCARBIDEARMOR = const ArmorType("A", "tungsten carbide armor", 19);
  
  static const ArmorType DIAMONDARMOR = const ArmorType("A", "diamond armor", 20);
  
  static const ArmorType HULKARMOR = const ArmorType("A", "hulk's skin", 21);
  
  static const ArmorType NOKIAARMOR = const ArmorType("A", "armor made from nokia", 22);
}