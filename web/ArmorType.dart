library ARMORTYPE;

import 'Enum.dart';

class ArmorType<String> extends Enum<String, String>
{
  final int def;
  const ArmorType(String val, String name, this.def) : super(val, name);
  
  static const ArmorType NONE = const ArmorType("A", "no armor", 0);
  static const ArmorType USEDIRONARMOR = const ArmorType("A", "used iron armor", 1);
  static const ArmorType IRONARMOR = const ArmorType("A", "iron armor", 2);
}