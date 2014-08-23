library WEAPONTYPE;

import 'Enum.dart';

class WeaponType<String> extends Enum<String, String>
{
  const WeaponType(String val, String name) : super(val, name);
  
  static const WeaponType IRONDAGGER = const WeaponType("W", "iron dagger");
}