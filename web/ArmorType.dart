library ARMORTYPE;

import 'Enum.dart';

class ArmorType<String> extends Enum<String, String>
{
  const ArmorType(String val, String name) : super(val, name);
  
  static const ArmorType USEDIRONARMOR = const ArmorType("A", "used iron armor");
}